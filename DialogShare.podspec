Pod::Spec.new do |s|
  s.name                    = "DialogShare"
  s.version                 = "0.0.1"
  s.summary                 = "Share SDK for Dialog Messaging apps"
  s.homepage                = "https://dlg.im/"
  s.license                 = { :type => 'MIT', :file => 'LICENSE' }
  s.author                  = { "Dialog LLC" => "services@dlg.im" }
  s.source                  = { :git => "*" }
  s.platform                = :ios, "11.0"
  s.requires_arc            = true
  s.vendored_frameworks     = "Products/DialogShare.framework"
end
