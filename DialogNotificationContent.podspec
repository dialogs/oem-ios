Pod::Spec.new do |s|
  s.name                    = "DialogNotificationContent"
  s.version                 = "0.0.1"
  s.summary                 = "Notification Content SDK for Dialog Messaging apps"
  s.homepage                = "https://dlg.im/"
  s.license                 = { :type => 'MIT', :file => 'LICENSE' }
  s.author                  = { "Dialog LLC" => "services@dlg.im" }
  s.source                  = { :git => "*" }
  s.platform                = :ios, "11.0"
  s.requires_arc            = true
  s.vendored_frameworks     = "Products/DialogNotificationContent.framework",
    "Dependencies/Internal/DialogNotificationContentExtension.framework",
    "Dependencies/Internal/DialogAuth.framework",
    "Dependencies/Internal/DialogFeatureFlags.framework",
    "Dependencies/Internal/DialogFiles.framework",
    "Dependencies/Internal/DialogMessaging.framework",
    "Dependencies/Internal/DialogMetrics.framework",
    "Dependencies/Internal/DialogNetService.framework",
    "Dependencies/Internal/DialogNetworking.framework",
    "Dependencies/Internal/DialogNotifications.framework",
    "Dependencies/Internal/DialogProtocols.framework",
    "Dependencies/Internal/DialogSecureStorage.framework",
    "Dependencies/Internal/DialogSharedComponents.framework",
    "Dependencies/Internal/DialogStorage.framework",
    "Dependencies/Internal/DialogSwiftGRPCExtra.framework",
    "Dependencies/Forks/DialogSDK_GRPC.framework"

  s.dependency 'gRPC', '~> 1.24'
  s.dependency 'gRPC-Core', '~> 1.24'
  s.dependency 'gRPC-ProtoRPC', '~> 1.24'
  s.dependency 'gRPC-RxLibrary', '~> 1.24'
  s.dependency 'RxCocoa', '5.1.1'
  s.dependency 'RxSwift', '5.1.0'
  s.dependency 'SwiftProtobuf', '1.7.0'
  s.dependency 'Swinject', '2.7.1'
end
