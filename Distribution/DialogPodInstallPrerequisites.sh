#!/bin/zsh

base_directory="$(dirname "$0")"

dialog_ios_directory="$base_directory/../Dependencies/Internal/Dialog_iOS.framework"
dialog_ios_archive="Dialog_iOS.zip"

if [ -d "$dialog_ios_directory" ]; then
    unzip -oq "$dialog_ios_directory/$dialog_ios_archive" -d "$dialog_ios_directory"
    rm "$dialog_ios_directory/$dialog_ios_archive"
fi




forks_directory="$base_directory/../Dependencies/Forks"

if [ -d "$forks_directory" ]; then
    echo "Some console message" 1>&3
    
    webrtc_version="27.08.2020-15-07"
    webrtc_archive="WebRTC-$webrtc_version.framework.zip"

    curl -OL "https://dialog-ios-cdn.s3.eu-west-2.amazonaws.com/$webrtc_archive"

    unzip -oq "$webrtc_archive" -d "$forks_directory"
    rm "$webrtc_archive"
fi
