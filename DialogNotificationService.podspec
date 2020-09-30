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
  s.vendored_frameworks     = "Products/DialogNotificationService.framework"

  s.dependency 'SwiftProtobuf', '1.7.0'
end