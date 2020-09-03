//
//  DialogAppDelegate.swift
//  Dialog
//
//  Created by Александр Клёмин on 28.08.2020.
//  Copyright © 2020 DIALOG. All rights reserved.
//

import Dialog_iOS
import DialogFeatureFlags
import DialogMetrics
import DialogProtocols
import RxSwift
import RxTheme
import Sentry
import UIKit
import Intents

public class DialogAppDelegate: CommonAppDelegate {
    
    public static let shared = DialogAppDelegate()
    
    static let endpoint: String = { Bundle.main.object(forInfoDictionaryKey: "Endpoint") as? String ?? "" }()
    
    static let apnsId: Int32 = { Int32(Bundle.main.object(forInfoDictionaryKey: "APNs ID") as? String ?? "") ?? 0 }()
    static let voipId: Int32 = { Int32(Bundle.main.object(forInfoDictionaryKey: "VoIP ID") as? String ?? "") ?? 0 }()
    
    static let sentryDSN: String = { Bundle.main.object(forInfoDictionaryKey: "Sentry DSN") as? String ?? "" }()

    static let deepLinkBaseUrls: [String] = {
        var urls = [String]()
        let keys = ["DeepLinks base url", "DeepLinks base url 2", "DeepLinks base url 3"]
        for key in keys {
            if let url = Bundle.main.object(forInfoDictionaryKey: key) as? String, !url.isEmpty {
                urls.append("https://" + url)
            }
        }
        return urls
    }()

    static let deepLinkScheme: String = {
        guard let urlTypes = Bundle.main.object(forInfoDictionaryKey: "CFBundleURLTypes") as? [Any],
            urlTypes.count > 0 else { return "" }
        
        guard let urlSchemes = (urlTypes[0] as? [String: Any])?["CFBundleURLSchemes"] as? [String],
            urlSchemes.count > 0 else { return "" }
        
        return urlSchemes[0]
    }()
    
    public var window: UIWindow?
    var appRouter: AppStrongRouter!
    let container = DialogContainer()
    
    let disposeBag = DisposeBag()
    
    private var applicationStartTime: UInt64?
    
    private var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    var secIdentity: SecIdentity?
    var urlToHandle: URL?
    
    private func launchUI() {
        guard let window = window else {
            Log.error("Failed to launch UI without window.")
            return
        }
        
        let fabric = container.resolve(CoordinatorFabricProtocol.self)!
        let appCoordinator: AnyAppCoordinator = fabric.create(parentContainer: container)
        
        let appRouter = appCoordinator.strongRouter
        self.appRouter = appRouter
        appRouter.setRoot(for: window)
    }
    
    private func registerServicesAndConfigs() {
        let configurator = Configurator()
        let assembler = DialogAssembler(container: container)
        
        container.register(DialogPeerColorsService.Config.self) { _ in
            return DialogPeerColorsService.Config(avatarColors: configurator.avatarColors)
        }
        
        assembler.registerDefaultDialogServices()
        
        configureSentry()
        
        configurator.configureTrustKit()
        
        container.register(DialogSecurityConfig.self) { _ in
            return DialogSecurityConfig.createFromDefault {
                $0.useSslPinning = configurator.useSslPinning
            }
        }
        
        container.register(DialogPushConfig.self) { _ in
            return .obsolete(apnsId: Self.apnsId, voipId: Self.voipId)
        }
        
        registerFeatureFlags(configurator.defaultFeatureFlags())
        
        container.register(DialogMetricsService.Config.self) { _ in
            return DialogMetricsService.Config(endpoint: Self.endpoint, uploadStrategy: .buffer(interval: 60 * 60, limit: 500))
        }
        
        if let distributionLink = Bundle.main.infoDictionary?["Distribution link"] as? String, !distributionLink.isEmpty,
            let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String, !version.isEmpty {
            container.register(AppVersionCheckServiceProtocol.self) { _ in
                return AppVersionCheckServiceEnterprise(distributionLink: distributionLink, currentVersion: version)
            }.inObjectScope(.container)
        }
        
        container.register(DeepLinkResolver.Config.self) { _ in
            return DeepLinkResolver.Config.createFromDefault {
                $0.scheme = Self.deepLinkScheme
                $0.baseUrls = Self.deepLinkBaseUrls
                $0.conferenceCallsConfig = DeepLinkResolver.Config.CallsConfig.createFromDefault {
                    $0.deepLinkPath = "call"
                    $0.allowCallWithDeepLink = configurator.conferenceCallsSupported
                    $0.requiredParams = ["confId"]
                }
            }
        }
    }
    
    private func configureSentry() {
        do {
            Client.shared = try Client(dsn: Self.sentryDSN)
            try Client.shared?.startCrashHandler()
        } catch let error {
            Log.error("\(error)")
        }
    }
    
    func registerFeatureFlags(_ flags: [DialogFeatureFlag]) {
        
        // TODO: We must copy all the flags until we moved to the new feature flag service.
        
        // Service 1 (to remove)
        container.register(DialogFeatureFlagsState.self) { _ in
            return DialogFeatureFlagsState(featureFlags: flags)
        }
        
        // Service 2 (the new one to work with)
        container.register(FeatureFlagConfig.self) { _ in
            return FeatureFlagConfig.default.modified {
                $0.defaultFlags = flags
            }
        }
    }
    
    func setupAuthRelatedConfigs() {
        let configurator = Configurator()
        
        container.register(DialogAuthConfig.self) { _ in
            return DialogAuthConfig.createFromDefault {
                $0.strategy = configurator.authStrategy
                $0.singleAuthOnly = true
                $0.defaultEndpoints = [Self.endpoint]
            }
        }
        
        var restorePasswordLink = ""
        var needHelpLink = ""
        
        if let authUIConfig = Bundle.main.object(forInfoDictionaryKey: "Auth UI Config") as? [String: Any] {
            if let link = authUIConfig["Restore password link"] as? String { restorePasswordLink = link }
            if let link = authUIConfig["Need help link"] as? String { needHelpLink = link }
        }
        
        container.register(DialogAuthUIConfig.self) { _ in
            return DialogAuthUIConfig.createFromDefault {
                $0.corporateLogo = UIImage.bundled("corporate_logo")
                $0.restorePasswordLink = restorePasswordLink
                $0.needHelpLink = needHelpLink
            }
        }
        
        container.register(DialogAuthPKIConfig.self) { _ in
            return DialogAuthPKIConfig.createFromDefault {
                $0 = configurator.authPKIConfig
            }
        }
        
        container.register(DialogAuthSecIdentityConfig.self) { _ in
            return DialogAuthSecIdentityConfig.createFromDefault {
                $0 = configurator.authSecIdentityConfig
            }
        }
    }
    
    func registerUIConfigs() {
        let configurator = Configurator()
        
        container.register(DialogConferenceUIConfig.self) { _ in
            return DialogConferenceUIConfig.createFromDefault {
                $0.removeBetaForcedly = configurator.removeBetaForcedlyForConference
            }
        }
        
        if configurator.useBasicTheme {
            if let themeService = container.resolve(AppThemeService.self), let tintColor = window?.rx.tintColor {
                themeService.generalControlColor().bind(to: tintColor).disposed(by: disposeBag)
            }
            
            return
        }
        
        container.register(AppThemeService.self) { [weak self] resolver in
            var theme = BasicAppTheme.appTheme
            
            theme.modify(subthemeForKeys: Theme.Keys.General.self) { theme in
                theme.set(colors: [
                    .controlActiveColor: configurator.corporateColor
                ])
            }
            
            theme.modify(subthemeForKeys: Theme.Keys.MessageBubbles.self) { theme in
                theme.set(colors: [
                    .messageBackgroundColor: UIColor.color { mode -> UIColor in
                        return mode == .dark ? UIColor(white: 0.2, alpha: 1.0) : #colorLiteral(red: 0.9499492049, green: 0.9499714971, blue: 0.9499594569, alpha: 1)
                    },
                    .myMessageBackgroundColor: configurator.corporateColor,
                    .replyIndentLineColor: configurator.corporateColor
                ])

                if configurator.bubbleColors.count > 0 {
                    theme.set(colors: configurator.bubbleColors)
                }
            }
            
            let provider = AppThemeProvider(id: configurator.themeName, theme: theme)
            let themeService = AppThemeProvider.service(initial: provider)
            
            if let self = self, let tintColor = self.window?.rx.tintColor {
                themeService.generalControlColor().bind(to: tintColor).disposed(by: self.disposeBag)
            }
            
            return themeService
        }.inObjectScope(.container)
    }
    
    /**
     Wait until system notifeis that protected data becomes available and then launch UI.
     In most cases launching UI will start on the next runloop.
     The only known exception for now is when VoIP push received while device is locked and app was killed for some reason.
     */
    func waitForProtectedDataBecomeAvailableToLaunchUI(application: UIApplication) {
        let service = container.resolve(ApplicationProtectedDataAvailabilityServiceProtocol.self)!
        
        let availabilityWaiter = service.applicationProtectedDataBecomeAvailableFirstTime
        // Tere should be main.async call because we needed to be prepared to handle VoIP pushes immediately.
        // Launching the UI could increase the loading time significant and trigger WatchDog.
        availabilityWaiter.observeOn(MainScheduler.asyncInstance)
            .subscribe(onCompleted: launchUI).disposed(by: disposeBag)
    }
    
    public func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        applicationStartTime = DispatchTime.now().uptimeNanoseconds
        
        registerServicesAndConfigs()
        
        setupAuthRelatedConfigs()
        
        registerUIConfigs()
        
        let rootViewController = container.resolveSceneViewController(EntryScene.self, resolver: container)!
        window?.rootViewController = rootViewController
        
        container.register(AppRootControllerHolder.self, factory: { _ in
            AppRootControllerHolder(rootViewController: rootViewController)
        })
        
        _ = container.resolve(GlobalNotificationUserProxyServiceProtocol.self)
        _ = container.resolve(PushRegistryServiceProtocol.self)
        
        waitForProtectedDataBecomeAvailableToLaunchUI(application: application)
        
        return true
    }
    
    public func applicationDidFinishLaunching(_ application: UIApplication) {
        guard let metricsService = container.resolve(ProtectedDataMetricsServiceProtocol.self),
            let start = applicationStartTime else {
            return
        }
        
        let time = DispatchTime.now().uptimeNanoseconds - start
        
        let firstRenderPaint = DialogTimingMetric(
            category: .app,
            variable: .firstRenderPaint,
            time: time,
            label: .none
        ).toDialogEvent()
        
        let visible = DialogEventMetric(category: .presence, action: .visible).toDialogEvent()
        
        metricsService.saveEvents(events: [firstRenderPaint, visible], instantly: false)
    }
    
    public func applicationWillTerminate(_ application: UIApplication) {
        guard let authStateService = container.resolve(AppAuthStateServiceProtocol.self) else {
            Log.error("No app auth state service found to check end remove call on the app termination")
            return
        }
        
        authStateService.doWithAuthedUserIgnoringOtherCases().asObservable().flatMap { [container] user -> Observable<Void> in
            guard let resolversProvider = container.resolve(SwinjectUserContainersServiceProtocol.self),
                let callsService = resolversProvider.getResolver(user: user)?.resolve(CallsServiceProtocol.self) else
            {
                Log.error("Fail to resolve call service on the app termination")
                return .empty()
            }
            
            guard let call = callsService.activeCall else {
                return .empty()
            }

            return call.hangup(withReason: .error).first().mapTo(Void()).asObservable()
        }.subscribe().disposed(by: disposeBag)
    }
    
    public func applicationWillEnterForeground(_ application: UIApplication) {
        subscribeToVersionCheckService()
        
        guard let metricsService = container.resolve(ProtectedDataMetricsServiceProtocol.self) else { return }
        
        let event = DialogEventMetric(category: .presence, action: .visible).toDialogEvent()
        metricsService.saveEvents(events: [event], instantly: false)
    }
    
    private func subscribeToVersionCheckService() {
        Log.info("VersionCheckService: check procedure started.")
        
        if let showUpdateMessageLastDate = UserDefaults.standard.object(forKey: "showUpdateMessageLastDate") as? Date,
            -showUpdateMessageLastDate.timeIntervalSinceNow < 180 * 60 {
            Log.info("VersionCheckService: too early to check.")
            return
        }
        
        let appVersionCheckService = container.resolve(AppVersionCheckServiceProtocol.self, name: nil)
        
        appVersionCheckService?.checkVersion().subscribe(onSuccess: {
            switch $0 {
            case .upToDate:
                Log.info("VersionCheckService: latest version installed.")

            case .update(let latestVersion, let updateLink):
                appVersionCheckService?.showUpdateMessage(latestVersion: latestVersion, updateLink: updateLink)
                UserDefaults.standard.set(Date(), forKey: "showUpdateMessageLastDate")
            }
        }).disposed(by: disposeBag)
    }
    
    public func applicationDidEnterBackground(_ application: UIApplication) {
        backgroundTask = application.beginBackgroundTask(
            expirationHandler: { [weak self] in
                guard let self = self else { return }
                
                application.endBackgroundTask(self.backgroundTask)
                self.backgroundTask = .invalid
            }
        )
        
        DispatchQueue.global(qos: .default).async { [weak self] in
            guard let self = self else { return }
            
            application.endBackgroundTask(self.backgroundTask)
            self.backgroundTask = .invalid
        }
        
        guard let metricsService = container.resolve(ProtectedDataMetricsServiceProtocol.self) else { return }
        
        let event = DialogEventMetric(category: .presence, action: .hidden).toDialogEvent()
        metricsService.saveEvents(events: [event], instantly: true)
    }
    
    public func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        switch userActivityType {
        case "INStartCallIntent":
            return true
        case "INStartAudioCallIntent":
            return true
        default:
            return false
        }
    }
    
    public func application(
        _ application: UIApplication,
        continue userActivity: NSUserActivity,
        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void
    ) -> Bool {

        if userActivity.activityType == NSUserActivityTypeBrowsingWeb, let url = userActivity.webpageURL {
            let deepLinkHandler = container.resolve(DeepLinkHandlerProtocol.self)
            deepLinkHandler?.handle(url: url, appRouter: appRouter)
            return true
        }

        guard let userActivityHandler = container.resolve(UserActivityHandlerProtocol.self) else { return false }
        
        return userActivityHandler.application(application, continue: userActivity, restorationHandler: restorationHandler)
    }
    
    public func application(_ app: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let authStateService = container.resolve(AppAuthStateServiceProtocol.self)!
        let resolversProvider = container.resolve(SwinjectUserContainersServiceProtocol.self)!
        
        authStateService.doWithAuthedUserIgnoringOtherCases().do(onNext: { user in
            guard let service = resolversProvider
                .getResolver(user: user)?
                .resolve(PushNotificationServiceAppDelegateInput.self) else {
                    Log.error("App did register for remote notifications, but there is no service to tell it")
                    return
                }
            
            service.application(app, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        }).subscribe().disposed(by: disposeBag)
    }
    
    public func application(_ app: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        let authStateService = container.resolve(AppAuthStateServiceProtocol.self)!
        let resolversProvider = container.resolve(SwinjectUserContainersServiceProtocol.self)!
        
        authStateService.doWithAuthedUserIgnoringOtherCases().do(onNext: { user in
            guard let service = resolversProvider
                .getResolver(user: user)?
                .resolve(PushNotificationServiceAppDelegateInput.self) else {
                    Log.error("App did fail to register for remote notifications. \(error)")
                    return
                }
            
            service.application(app, didFailToRegisterForRemoteNotificationsWithError: error)
        }).subscribe().disposed(by: disposeBag)
    }
    
    public func application(_ app: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        let info = NotificationInfo.anonymous(.init(payload: userInfo, completionHandler: completionHandler))
        container
            .resolve(GlobalNotificationUserProxyServiceProtocol.self)?
            .handleNotification(info)
    }
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        let deepLinkHandler = container.resolve(DeepLinkHandlerProtocol.self)
        deepLinkHandler?.handle(url: url, appRouter: appRouter)
        
        return true
    }
    
}
