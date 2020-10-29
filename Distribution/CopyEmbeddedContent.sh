#!/bin/zsh

external_dependencies=(
    "Alamofire"
    "openssl"                   # BoringSSL
    "openssl_grpc"              # BoringSSL-GRPC
    "Cache"
    "Differentiator"
    "FLAnimatedImage"
    "GRDB"
    "GRPCClient"                # gRPC
    "grpc"                      # gRPC-Core
    "ProtoRPC"                  # gRPC-ProtoRPC
    "RxLibrary"                 # gRPC-RxLibrary
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
    "RxBiBinding"
    "RxCocoa"
    "RxDataSources"
    "RxGesture"
    "RxKeyboard"
    "RxRelay"
    "RxSwift"
    "RxSwiftExt"
    "RxTheme"
    "RxWebKit"
    "SnapKit"
    "SQLCipher"
    "SwiftDate"
    "SwiftGRPC"
    "SwiftProtobuf"
    "Swinject"
    "TrustKit"
    "ViewAnimator"
    "XCGLogger"
)

forks=(
    "Dialog_gRPC_Objc"          # Dialog-gRPC-Objc
    "DialogCalls_GRPC"          # DialogCalls-GRPC
    "DialogSDK_GRPC"            # DialogSDK-GRPC
    "WebRTC"                    # DialogWebRTC
    "DLGPicker"
    "InputBarAccessoryView"
    "RxASDataSources"
    "RxCocoa_Texture"           # RxCocoa-Texture
    "Sentry"
    "Sodium"
    "AsyncDisplayKit"           # Texture
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
