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
  s.vendored_frameworks     = "Products/Dialog.framework"

  s.prepare_command         = <<-CMD
                                  Distribution/DialogPodInstallPrerequisites.sh
                                CMD

  s.dependency 'Alamofire', '4.8.2'
  s.dependency 'BoringSSL', '10.0.6'
  s.dependency 'Cache', '5.2.0'
  s.dependency 'Dialog-gRPC-Objc'#, :git => 'https://github.com/dialogs/api-schema.git', :branch => 'feature/objc_support'
  s.dependency 'DialogCalls-GRPC'#, :git => 'git@github.com:dialogs/server-api-calls-sdk.git', :tag => '2.19.0'
  s.dependency 'DialogSDK-GRPC'#, :git => 'https://github.com/dialogs/api-schema.git', :tag => 'v1.69.0'
  s.dependency 'DialogWebRTC'#, :git => 'git@github.com:dialogs/dialog-webrtc-ios-pod.git', :tag => '27.08.2020-15-07'
  s.dependency 'Differentiator', '4.0.0'
  s.dependency 'DLGPicker'#, :git => 'https://github.com/dialogs/Alerts-Pickers', :tag => '1.0.41'
  s.dependency 'FLAnimatedImage', '1.0.12'
  s.dependency 'GRDB.swift/SQLCipher', '~> 4.14.0'
  s.dependency 'gRPC', '~> 1.24'
  s.dependency 'gRPC-Core', '~> 1.24'
  s.dependency 'gRPC-ProtoRPC', '~> 1.24'
  s.dependency 'gRPC-RxLibrary', '~> 1.24'
  s.dependency 'InputBarAccessoryView'#, :git => 'https://github.com/nathantannar4/InputBarAccessoryView.git', :tag => '5.0.0'
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
  s.dependency 'RxASDataSources'#, :git => 'https://github.com/dialogs/RxASDataSources', :tag => '1.0.0.1'
  s.dependency 'RxBiBinding', '0.2.5'
  s.dependency 'RxCocoa', '5.1.1'
  s.dependency 'RxCocoa-Texture'#, :git => 'https://github.com/jeffersonsetiawan/RxCocoa-Texture.git', :branch => 'texture3'
  s.dependency 'RxDataSources', '4.0.1'
  s.dependency 'RxGesture', '3.0.2'
  s.dependency 'RxKeyboard', '1.0.0'
  s.dependency 'RxSwift', '5.1.0'
  s.dependency 'RxSwiftExt/Core', '5.2.0'
  s.dependency 'RxTheme', '4.0.0'
  s.dependency 'RxWebKit', '1.0.0'
  s.dependency 'Sentry'#, :git => 'https://github.com/getsentry/sentry-cocoa.git', :tag => '5.2.2'
  s.dependency 'SnapKit', '5.0.1'
  s.dependency 'Sodium'#, :git => 'https://github.com/dialogs/swift-sodium.git', :tag => '0.8.1'
  s.dependency 'SQLCipher', '~> 4.0'
  s.dependency 'SwiftDate', '6.0.3'
  s.dependency 'SwiftGRPC', '0.11.0'
  s.dependency 'SwiftProtobuf', '1.7.0'
  s.dependency 'Swinject', '2.7.1'
  s.dependency 'Texture'#, :git => 'https://github.com/dialogs/Texture.git', :tag => '3.0.0.1'
  s.dependency 'TrustKit', '1.6.3'
  s.dependency 'ViewAnimator', '2.7.0'
  s.dependency 'XCGLogger', '7.0.1'
  s.dependency 'XCoordinator/RxSwift'#, :git => 'https://github.com/quickbirdstudios/XCoordinator', :tag => '2.0.7'
end
