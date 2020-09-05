#!/bin/zsh

dialog_ios_archive="Dialog.framework/Frameworks/Dialog_iOS.framework/Dialog_iOS.zip"

unzip -o -q $dialog_ios_archive
rm $dialog_ios_archive
