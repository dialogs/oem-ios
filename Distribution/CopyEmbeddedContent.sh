#!/bin/zsh

external_dependencies=(
    "Alamofire"
    "openssl"                   # BoringSSL
    "openssl_grpc"              # BoringSSL-GRPC
    "Cache"
    "DialogCalls_GRPC"          # DialogCalls-GRPC
    "DialogSDK_GRPC"            # DialogSDK-GRPC
    "WebRTC"                    # DialogWebRTC
    "Differentiator"
    "DLGPicker"
    "FLAnimatedImage"
    "GRDB"
    "GRPCClient"                # gRPC
    "grpc"                      # gRPC-Core
    "ProtoRPC"                  # gRPC-ProtoRPC
    "RxLibrary"                 # gRPC-RxLibrary
    "InputBarAccessoryView"
    "KeychainAccess"
    "nanopb"
    "ObjcExceptionBridging"
    "PhoneNumberKit"
    "PINCache"
    "PINOperation"
    "PINRemoteImage"
    "Protobuf"
    "Reachability"              # ReachabilitySwift
    "RSKImageCropper"
    "RxAlamofire"
    "RxAnimated"
    "RxASDataSources"
    "RxBiBinding"
    "RxCocoa"
    "RxCocoa_Texture"           # RxCocoa-Texture
    "RxDataSources"
    "RxGesture"
    "RxKeyboard"
    "RxRelay"
    "RxSwift"
    "RxSwiftExt"
    "RxTheme"
    "RxWebKit"
    "Sentry"
    "SnapKit"
    "Sodium"
    "SQLCipher"
    "SwiftDate"
    "SwiftGRPC"
    "SwiftProtobuf"
    "Swinject"
    "AsyncDisplayKit"           # Texture
    "TrustKit"
    "ViewAnimator"
    "XCGLogger"
    "XCoordinator"
)

function external_dependencies_contains {
    external_dependencies_contains_result=false

    for external_dependency in $external_dependencies; do
        if [[ "$1" = *"/$external_dependency.framework" ]]; then
            external_dependencies_contains_result=true
            break
        fi
    done
}

base_directory="$(dirname "$0")"

source_directory="$base_directory/../Pods/_Prebuild/GeneratedFrameworks"

target_directory="$base_directory/../EmbeddedContent"
rm -rf "$target_directory"
mkdir "$target_directory"

pushd "$source_directory" > /dev/null

for framework in $(find . -name '*.framework'); do
    external_dependencies_contains "$framework"

    if [ $external_dependencies_contains_result = false ]; then
        cp -r "$framework" "../../../$target_directory"
    fi
done

popd > /dev/null
