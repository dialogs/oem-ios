Pod::Spec.new do |s|
  s.name                    = "Dialog"
  s.version                 = "0.0.1"
  s.summary                 = "SDK for Dialog Messaging apps"
  s.homepage                = "https://dlg.im/"
  s.license                 = { :type => 'MIT', :file => 'LICENSE' }
  s.author                  = { "Dialog LLC" => "services@dlg.im" }
  s.source                  = { :git => "*" }
  s.platform                = :ios, "11.0"
  s.requires_arc            = true
  s.vendored_frameworks     = "Products/Dialog.framework",
    "Dependencies/Internal/Dialog_iOS.framework",
    "Dependencies/Internal/DialogAuth.framework",
    "Dependencies/Internal/DialogBasics.framework",
    "Dependencies/Internal/DialogCalls.framework",
    "Dependencies/Internal/DialogFeatureFlags.framework",
    "Dependencies/Internal/DialogFiles.framework",
    "Dependencies/Internal/DialogFilter.framework",
    "Dependencies/Internal/DialogMessaging.framework",
    "Dependencies/Internal/DialogMetrics.framework",
    "Dependencies/Internal/DialogMiniAppService.framework",
    "Dependencies/Internal/DialogMuteSettingsService.framework",
    "Dependencies/Internal/DialogNetService.framework",
    "Dependencies/Internal/DialogNetworking.framework",
    "Dependencies/Internal/DialogNotifications.framework",
    "Dependencies/Internal/DialogPasscode.framework",
    "Dependencies/Internal/DialogPasscodeUI.framework",
    "Dependencies/Internal/DialogPrivateProfile.framework",
    "Dependencies/Internal/DialogProtocols.framework",
    "Dependencies/Internal/DialogRx.framework",
    "Dependencies/Internal/DialogSearching.framework",
    "Dependencies/Internal/DialogSecureStorage.framework",
    "Dependencies/Internal/DialogSettingsConfigService.framework",
    "Dependencies/Internal/DialogSharedComponents.framework",
    "Dependencies/Internal/DialogSpeech.framework",
    "Dependencies/Internal/DialogStorage.framework",
    "Dependencies/Internal/DialogSwiftGRPCExtra.framework",
    "Dependencies/Internal/DialogUserTiedSecIdentityStorage.framework",
    "Dependencies/Internal/OpusIOS.framework",
    "Dependencies/Forks/AsyncDisplayKit.framework",
    "Dependencies/Forks/Dialog_gRPC_Objc.framework",
    "Dependencies/Forks/DialogCalls_GRPC.framework",
    "Dependencies/Forks/DialogSDK_GRPC.framework",
    "Dependencies/Forks/DLGPicker.framework",
    "Dependencies/Forks/InputBarAccessoryView.framework",
    "Dependencies/Forks/RxASDataSources.framework",
    "Dependencies/Forks/RxCocoa_Texture.framework",
    "Dependencies/Forks/Sentry.framework",
    "Dependencies/Forks/Sodium.framework",
    "Dependencies/Forks/WebRTC.framework",
    "Dependencies/Forks/XCoordinator.framework"

  s.prepare_command         = <<-CMD
                                  Distribution/DialogPodInstallPrerequisites.sh
                                CMD

  s.dependency 'Alamofire', '4.8.2'
  s.dependency 'BoringSSL', '10.0.6'
  s.dependency 'Cache', '5.2.0'
  s.dependency 'Differentiator', '4.0.0'
  s.dependency 'FLAnimatedImage', '1.0.12'
  s.dependency 'GRDB.swift/SQLCipher', '~> 4.14.0'
  s.dependency 'gRPC', '~> 1.24'
  s.dependency 'gRPC-Core', '~> 1.24'
  s.dependency 'gRPC-ProtoRPC', '~> 1.24'
  s.dependency 'gRPC-RxLibrary', '~> 1.24'
  s.dependency 'KeychainAccess', '3.2.0'
  s.dependency 'nanopb', '0.3.901'
  s.dependency 'ObjcExceptionBridging', '1.0.1'
  s.dependency 'PhoneNumberKit', '2.5.1'
  s.dependency 'PINCache', '3.0.1'
  s.dependency 'PINOperation', '1.2.0'
  s.dependency 'PINRemoteImage', '3.0.1'
  s.dependency 'Protobuf', '3.13.0'
  s.dependency 'ReachabilitySwift', '5.0.0'
  s.dependency 'RSKImageCropper', '2.2.2'
  s.dependency 'RxAlamofire', '5.0.0'
  s.dependency 'RxAnimated', '0.7.0'
  s.dependency 'RxBiBinding', '0.2.5'
  s.dependency 'RxCocoa', '5.1.1'
  s.dependency 'RxDataSources', '4.0.1'
  s.dependency 'RxGesture', '3.0.2'
  s.dependency 'RxKeyboard', '1.0.0'
  s.dependency 'RxSwift', '5.1.0'
  s.dependency 'RxSwiftExt/Core', '5.2.0'
  s.dependency 'RxTheme', '4.0.0'
  s.dependency 'RxWebKit', '1.0.0'
  s.dependency 'SnapKit', '5.0.1'
  s.dependency 'SQLCipher', '~> 4.0'
  s.dependency 'SwiftDate', '6.0.3'
  s.dependency 'SwiftGRPC', '0.11.0'
  s.dependency 'SwiftProtobuf', '1.7.0'
  s.dependency 'Swinject', '2.7.1'
  s.dependency 'TrustKit', '1.6.3'
  s.dependency 'ViewAnimator', '2.7.0'
  s.dependency 'XCGLogger/UserInfoHelpers', '7.0.1'
end
