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
  s.vendored_frameworks     = "Products/DialogNotificationContent.framework", "Products/DialogNotificationContent.framework/Internal Dependencies/*"

  s.dependency 'gRPC', '~> 1.24'
  s.dependency 'gRPC-Core', '~> 1.24'
  s.dependency 'gRPC-ProtoRPC', '~> 1.24'
  s.dependency 'gRPC-RxLibrary', '~> 1.24'
  s.dependency 'SwiftProtobuf', '1.7.0'
end
