#!/bin/zsh

#  DistributeProduct.sh
#  WhiteLabel
#
#  Created by Александр Клёмин on 19.09.2020.
#  Copyright © 2020 DIALOG. All rights reserved.

if [[ $OBJROOT == *"Extra" ]]; then
    exit 0
fi

products_directory="$PROJECT_DIR/Products"
product_path="$products_directory/$PRODUCT_NAME.framework"

mkdir "$products_directory"
rm -rf "$product_path"

scheme_name=$(/usr/libexec/PlistBuddy -c "Print \"Scheme name\"" "$INFOPLIST_FILE")

cp -r "$CONFIGURATION_BUILD_DIR/$CONTENTS_FOLDER_PATH" "$product_path"

if [[ $SWIFT_ACTIVE_COMPILATION_CONDITIONS = *"FAT"* ]]; then
    if [ $(lipo -archs $CONFIGURATION_BUILD_DIR/$CONTENTS_FOLDER_PATH/$PRODUCT_NAME) = "arm64" ]; then
        xcodebuild -workspace "Dialog.xcworkspace" -scheme "$scheme_name" -configuration "$CONFIGURATION" \
            -arch "x86_64" -sdk "iphonesimulator" OBJROOT="$OBJROOT/Extra"
            
        CONFIGURATION_BUILD_DIR_EXTRA=${CONFIGURATION_BUILD_DIR/"iphoneos"/"iphonesimulator"}
        
        lipo -create -output "$product_path/$PRODUCT_NAME" \
            "$CONFIGURATION_BUILD_DIR/$CONTENTS_FOLDER_PATH/$PRODUCT_NAME" \
            "$CONFIGURATION_BUILD_DIR_EXTRA/$CONTENTS_FOLDER_PATH/$PRODUCT_NAME"
            
        cp -r "$CONFIGURATION_BUILD_DIR_EXTRA/$CONTENTS_FOLDER_PATH/Modules/$PRODUCT_NAME.swiftmodule/." \
            "$product_path/Modules/$PRODUCT_NAME.swiftmodule/"
    fi
fi

rm "$product_path/DistributeProduct.sh"

dialog_ios="Dialog_iOS"
dialog_ios_path="$product_path/Frameworks/$dialog_ios.framework"

if [ -d "$dialog_ios_path" ]; then
    pushd "$dialog_ios_path" > /dev/null
        zip -q "$dialog_ios.zip" "$dialog_ios"
        rm "$dialog_ios"
    popd > /dev/null
fi
