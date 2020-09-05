#!/bin/zsh

dialog_ios_directory="Dialog.framework/Frameworks/Dialog_iOS.framework"
dialog_ios_archive="Dialog_iOS.zip"

unzip -oq "$dialog_ios_directory/$dialog_ios_archive" -d "$dialog_ios_directory"
rm "$dialog_ios_directory/$dialog_ios_archive"
