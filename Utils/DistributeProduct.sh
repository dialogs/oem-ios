#!/bin/zsh

#  DistributeProduct.sh
#  WhiteLabel
#
#  Created by Александр Клёмин on 19.09.2020.
#  Copyright © 2020 DIALOG. All rights reserved.

products_directory="$PROJECT_DIR/Products"
product_path="$products_directory/$PRODUCT_NAME.framework"

mkdir "$products_directory"
rm -rf "$product_path"
cp -r "$CONFIGURATION_BUILD_DIR/$CONTENTS_FOLDER_PATH" "$product_path"
rm "$product_path/DistributeProduct.sh"

dialog_ios="Dialog_iOS"
dialog_ios_path="$product_path/Frameworks/$dialog_ios.framework"

if [ -d "$dialog_ios_path" ]; then
    pushd "$dialog_ios_path" > /dev/null
        zip -q "$dialog_ios.zip" "$dialog_ios"
        rm "$dialog_ios"
    popd > /dev/null
fi
