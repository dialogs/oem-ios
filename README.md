# Dialog OEM

Dialog OEM is a messaging library written in Swift.

## Requirements

* iOS 11+
* Xcode 12+
* Swift 5+

## Installation

Dialog OEM consists of 4 frameworks:

* Dialog.framework (required, to be integrated into main application target)
* DialogNotificationService.framework (optional, to be integrated into Notification Service extension)
* DialogShare.framework (optional, to be integrated into Share extension)
* DialogNotificationContent.framework (optional, to be integrated into Notification Content extension)

### CocoaPods

[CocoaPods](https://cocoapods.org/) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate Dialog OEM frameworks into your Xcode project using CocoaPods, specify them in your `Podfile`:
```ruby
target 'Your App Main Target' do
    use_frameworks!
 
    pod 'Dialog', :git => 'git@github.com:dialogs/oem-ios.git', :branch => 'pre-release'
end
 
target 'Your App Notification Service Target' do
    use_frameworks!
 
    pod 'DialogNotificationService', :git => 'git@github.com:dialogs/oem-ios.git', :branch => 'pre-release'
end
 
target 'Your App Share Target' do
    use_frameworks!
 
    pod 'DialogShare', :git => 'git@github.com:dialogs/oem-ios.git', :branch => 'pre-release'
end
 
target 'Your App Notification Content Target' do
    use_frameworks!
 
    pod 'DialogNotificationContent', :git => 'git@github.com:dialogs/oem-ios.git', :branch => 'pre-release'
end
```

Dialog OEM frameworks are binary frameworks built without `BUILD_LIBRARY_FOR_DISTRIBUTION` support, so pay attention to Xcode version consistency.

Dialog.framework contains the following external dependencies:

* 'Alamofire', '4.8.2'
* 'BoringSSL', '10.0.6'
* 'Cache', '5.2.0'
* 'Differentiator', '4.0.0'
* 'FLAnimatedImage', '1.0.12'
* 'GRDB.swift/SQLCipher', '~> 4.14.0'
* 'gRPC', '~> 1.24'
* 'gRPC-Core', '~> 1.24'
* 'gRPC-ProtoRPC', '~> 1.24'
* 'gRPC-RxLibrary', '~> 1.24'
* 'KeychainAccess', '3.2.0'
* 'nanopb', '0.3.901'
* 'ObjcExceptionBridging', '1.0.1'
* 'PhoneNumberKit', '2.5.1'
* 'PINCache', '3.0.1'
* 'PINOperation', '1.2.0'
* 'PINRemoteImage', '3.0.1'
* 'Protobuf', '3.13.0'
* 'ReachabilitySwift', '5.0.0'
* 'RSKImageCropper', '2.2.2'
* 'RxAlamofire', '5.0.0'
* 'RxAnimated', '0.7.0'
* 'RxBiBinding', '0.2.5'
* 'RxCocoa', '5.1.1'
* 'RxDataSources', '4.0.1'
* 'RxGesture', '3.0.2'
* 'RxKeyboard', '1.0.0'
* 'RxSwift', '5.1.0'
* 'RxSwiftExt/Core', '5.2.0'
* 'RxTheme', '4.0.0'
* 'RxWebKit', '1.0.0'
* 'SnapKit', '5.0.1'
* 'SQLCipher', '~> 4.0'
* 'SwiftDate', '6.0.3'
* 'SwiftGRPC', '0.11.0'
* 'SwiftProtobuf', '1.7.0'
* 'Swinject', '2.7.1'
* 'TrustKit', '1.6.3'
* 'ViewAnimator', '2.7.0'
* 'XCGLogger/UserInfoHelpers', '7.0.1'

and fork dependencies (distributed as binary frameworks when integrating Dialog.framework):

* 'Dialog-gRPC-Objc', :git => 'git@github.com:dialogs/api-schema.git', :branch => 'feature/objc_support'
* 'DialogCalls-GRPC', :git => 'git@github.com:dialogs/server-api-calls-sdk.git', :tag => '2.19.0'
* 'DialogSDK-GRPC', :git => 'git@github.com:dialogs/api-schema.git', :tag => 'v1.76.0'
* 'DialogWebRTC', :git => 'git@github.com:dialogs/dialog-webrtc-ios-pod.git', :tag => '27.08.2020-15-07'
* 'DLGPicker', :git => 'git@github.com:dialogs/Alerts-Pickers', :tag => '1.0.43'
* 'Emoji-swift', :git => 'git@github.com:safx/Emoji-Swift.git', :branch => 'master'
* 'InputBarAccessoryView', :git => 'git@github.com:nathantannar4/InputBarAccessoryView.git', :tag => '5.1.0'
* 'RxASDataSources', :git => 'git@github.com:dialogs/RxASDataSources', :tag => '1.0.0.1'
* 'RxCocoa-Texture', :git => 'git@github.com:jeffersonsetiawan/RxCocoa-Texture.git', :branch => 'texture3'
* 'Sentry', :git => 'git@github.com:getsentry/sentry-cocoa.git', :tag => '5.2.2'
* 'Sodium', :git => 'git@github.com:dialogs/swift-sodium.git', :tag => '0.8.1'
* 'Texture', :git => 'git@github.com:dialogs/Texture.git', :tag => '3.0.0.2'
* 'XCoordinator/RxSwift', :git => 'git@github.com:quickbirdstudios/XCoordinator', :tag => '2.0.7'