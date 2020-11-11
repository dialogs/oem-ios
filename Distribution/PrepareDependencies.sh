#!/bin/zsh

internal_dependencies=(
    "Dialog_iOS"                                # Dialog-iOS
    "DialogAuth"
    "DialogBasics"
    "DialogCalls"
    "DialogFeatureFlags"
    "DialogFiles"
    "DialogFilter"
    "DialogIntentsExtension"
    "DialogMessaging"
    "DialogMetrics"
    "DialogMiniAppService"
    "DialogMuteSettingsService"
    "DialogNetService"
    "DialogNetworking"
    "DialogNotificationContentExtension"
    "DialogNotifications"
    "DialogNotificationServiceExtension"
    "DialogPasscode"
    "DialogPasscodeUI"
    "DialogPrivateProfile"
    "DialogProtocols"
    "DialogRx"
    "DialogSearching"
    "DialogSecureStorage"
    "DialogSettingsConfigService"
    "DialogSharedComponents"
    "DialogShareExtension"
    "DialogSpeech"
    "DialogStorage"
    "DialogSwiftGRPCExtra"
    "DialogUserTiedSecIdentityStorage"
    "JSBridge"
    "OpusIOS"
)

forks=(
    "Dialog_gRPC_Objc"                          # Dialog-gRPC-Objc
    "DialogCalls_GRPC"                          # DialogCalls-GRPC
    "DialogSDK_GRPC"                            # DialogSDK-GRPC
  # "WebRTC"                                    # DialogWebRTC
    "DLGPicker"
    "Emoji"                                     # Emoji-swift
    "InputBarAccessoryView"
    "RxASDataSources"
    "RxCocoa_Texture"                           # RxCocoa-Texture
    "Sentry"
    "Sodium"
    "AsyncDisplayKit"                           # Texture
    "XCoordinator"
)

function dependencies_list_contains {
    framework="$1"

    shift
    dependencies_list=("$@")

    dependencies_list_contains_result=false

    for dependency in "${dependencies_list[@]}"; do
        if [[ "$framework" = *"/$dependency.framework" ]]; then
            dependencies_list_contains_result=true
            break
        fi
    done
}

function copy_dependencies {
    source_directory="$1"
    target_directory="$2"

    shift
    shift
    dependencies_list=("$@")

    rm -rf "$target_directory"
    mkdir "$target_directory"

    pushd "$source_directory" > /dev/null

    for framework in $(find . -name '*.framework'); do
        dependencies_list_contains "$framework" "${dependencies_list[@]}"

        if [ $dependencies_list_contains_result = true ]; then
            popd > /dev/null
            cp -r "$source_directory/$framework" "$target_directory"
            pushd "$source_directory" > /dev/null
        fi
    done

    popd > /dev/null
}

base_directory="$(dirname "$0")"

source_directory="$base_directory/../Pods/_Prebuild/GeneratedFrameworks"

target_directory_internal_dependencies="$base_directory/../Dependencies/Internal"
target_directory_forks="$base_directory/../Dependencies/Forks"

copy_dependencies "$source_directory" "$target_directory_internal_dependencies" "${internal_dependencies[@]}"
copy_dependencies "$source_directory" "$target_directory_forks" "${forks[@]}"

dialog_ios="Dialog_iOS"
dialog_ios_path="$target_directory_internal_dependencies/$dialog_ios.framework"

if [ -d "$dialog_ios_path" ]; then
    pushd "$dialog_ios_path" > /dev/null
        zip -q "$dialog_ios.zip" "$dialog_ios"
        rm "$dialog_ios"
    popd > /dev/null
fi
