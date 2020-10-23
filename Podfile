$deploymentTarget = '11.0'

platform :ios, $deploymentTarget

$SDKPodsPath = 'git@github.com:dialogs/dialog-swift-platform.git'
$tempPath = '.temp'

def source_type
    :branch
end

$sourceValue = 'develop'

$prebuildFrameworks = false

if $prebuildFrameworks
    plugin 'cocoapods-binary'
end

# work-around because github.com doesn't support git-archive protocol: https://github.com/isaacs/github/issues/554
system('git clone --depth 1 --branch ' + $sourceValue + ' ' + $SDKPodsPath + ' ' + $tempPath)
load $tempPath + '/' + 'CommonPods.rb'
system('rm -rf ' + $tempPath)

# Pods for Dialog SDK
def dialog_sdk_pods
    pod 'Dialog-iOS', :git => $SDKPodsPath, source_type => $sourceValue

    pod 'DialogAuth', :git => $SDKPodsPath, source_type => $sourceValue
    pod 'DialogBasics', :git => $SDKPodsPath, source_type => $sourceValue
    pod 'DialogRx', :git => $SDKPodsPath, source_type => $sourceValue
    pod 'DialogFeatureFlags', :git => $SDKPodsPath, source_type => $sourceValue
    pod 'DialogFiles', :git => $SDKPodsPath, source_type => $sourceValue
    pod 'DialogMetrics', :git => $SDKPodsPath, source_type => $sourceValue
    pod 'DialogMessaging', :git => $SDKPodsPath, source_type => $sourceValue
    pod 'DialogMuteSettingsService', :git => $SDKPodsPath, source_type => $sourceValue
    pod 'DialogNetworking', :git => $SDKPodsPath, source_type => $sourceValue
    pod 'DialogNotifications', :git => $SDKPodsPath, source_type => $sourceValue
    pod 'DialogProtocols', :git => $SDKPodsPath, source_type => $sourceValue

    pod 'DialogSecureStorage', :git => $SDKPodsPath, source_type => $sourceValue
    pod 'DialogSettingsConfigService', :git => $SDKPodsPath, source_type => $sourceValue
    pod 'DialogStorage', :git => $SDKPodsPath, source_type => $sourceValue
    pod 'DialogFilter', :git => $SDKPodsPath, source_type => $sourceValue
    pod 'DialogSwiftGRPCExtra', :git => $SDKPodsPath, source_type => $sourceValue
    pod 'DialogUserTiedSecIdentityStorage', :git => $SDKPodsPath, source_type => $sourceValue
    pod 'DialogPrivateProfile', :git => $SDKPodsPath, source_type => $sourceValue
    pod 'DialogSearching', :git => $SDKPodsPath, source_type => $sourceValue
    pod 'DialogNetService', :git => $SDKPodsPath, source_type => $sourceValue
    pod 'DialogCalls', :git => $SDKPodsPath, source_type => $sourceValue
    pod 'DialogPasscode', :git => $SDKPodsPath, source_type => $sourceValue
    pod 'DialogPasscodeUI', :git => $SDKPodsPath, source_type => $sourceValue
    pod 'DialogSharedComponents', :git => $SDKPodsPath, source_type => $sourceValue
    pod 'OpusIOS', :git => $SDKPodsPath, source_type => $sourceValue
    pod 'DialogSpeech', :git => $SDKPodsPath, source_type => $sourceValue
    pod 'DialogMiniAppService', :git => $SDKPodsPath, source_type => $sourceValue

    call_pods
end

# Pods for Notification Service Extension
def notification_service_extension_pods
    pod 'DialogNotificationServiceExtension', :git => $SDKPodsPath, source_type => $sourceValue
end

# Pods for Share Extension
def share_extension_pods
    pod 'DialogShareExtension', :git => $SDKPodsPath, source_type => $sourceValue
end

# Pods for Notification Content Extension
def notification_content_extension_pods
    pod 'DialogNotificationContentExtension', :git => $SDKPodsPath, source_type => $sourceValue
end

# Pods for Intents Extension
def intents_extension_pods
    pod 'DialogIntentsExtension', :git => $SDKPodsPath, source_type => $sourceValue
end

target 'Dialog' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!

    if $prebuildFrameworks
        enable_bitcode_for_prebuilt_frameworks!
        all_binary!
    end

    dialog_sdk_pods
    dialog_master_app_pods
    shared_pods
    rx_pods
end

target 'DialogNotificationService' do
    use_frameworks!

    if $prebuildFrameworks
        enable_bitcode_for_prebuilt_frameworks!
        all_binary!
    end

    notification_service_extension_pods
    shared_pods
end

target 'DialogShare' do
    use_frameworks!

    if $prebuildFrameworks
        enable_bitcode_for_prebuilt_frameworks!
        all_binary!
    end

    share_extension_pods
    shared_pods
end

target 'DialogNotificationContent' do
    use_frameworks!

    if $prebuildFrameworks
        enable_bitcode_for_prebuilt_frameworks!
        all_binary!
    end

    notification_content_extension_pods
    shared_pods
end

target 'DialogIntents' do
    use_frameworks!

    if $prebuildFrameworks
        enable_bitcode_for_prebuilt_frameworks!
        all_binary!
    end

    intents_extension_pods
    shared_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == 'Dialog-iOS'
            target.build_configurations.each do |config|
                config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] ||= ['$(inherited)']
                config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] <<  "AS_USE_VIDEO=1"
            end
        end

        target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = $deploymentTarget
            config.build_settings['DEPLOYMENT_POSTPROCESSING'] = 'YES'
        end
    end
end
