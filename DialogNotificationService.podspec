Pod::Spec.new do |s|
  s.name                    = "DialogNotificationService"
  s.version                 = "0.0.1"
  s.summary                 = "Notification Service SDK for Dialog Messaging apps"
  s.homepage                = "https://dlg.im/"
  s.license                 = { :type => 'MIT', :file => 'LICENSE' }
  s.author                  = { "Dialog LLC" => "services@dlg.im" }
  s.source                  = { :git => "*" }
  s.platform                = :ios, "11.0"
  s.requires_arc            = true
  s.vendored_frameworks     = "Products/DialogNotificationService.framework",
    "Dependencies/Internal/DialogNotificationServiceExtension.framework",
    "Dependencies/Internal/DialogAuth.framework",
    "Dependencies/Internal/DialogFiles.framework",
    "Dependencies/Internal/DialogMessaging.framework",
    "Dependencies/Internal/DialogNotifications.framework",
    "Dependencies/Internal/DialogProtocols.framework",
    "Dependencies/Internal/DialogSecureStorage.framework",
    "Dependencies/Internal/DialogSettingsConfigService.framework",
    "Dependencies/Internal/DialogSharedComponents.framework",
    "Dependencies/Internal/DialogStorage.framework",
    "Dependencies/Forks/DialogSDK_GRPC.framework"

  s.dependency 'GRDB.swift', '~> 5.3.0'
  s.dependency 'gRPC', '~> 1.24'
  s.dependency 'gRPC-Core', '~> 1.24'
  s.dependency 'gRPC-ProtoRPC', '~> 1.24'
  s.dependency 'gRPC-RxLibrary', '~> 1.24'
  s.dependency 'SwiftGRPC', '0.11.0'
  s.dependency 'SwiftProtobuf', '1.7.0'
end
