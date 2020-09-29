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
