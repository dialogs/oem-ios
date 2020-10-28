#!/bin/zsh

base_directory="$(dirname "$0")"

dialog_ios_directory="$base_directory/../Products/Dialog.framework/Internal Dependencies/Dialog_iOS.framework"
dialog_ios_archive="Dialog_iOS.zip"

if [ -d "$dialog_ios_directory" ]; then
    unzip -oq "$dialog_ios_directory/$dialog_ios_archive" -d "$dialog_ios_directory"
    rm "$dialog_ios_directory/$dialog_ios_archive"
fi
