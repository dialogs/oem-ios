#!/bin/zsh

#  DistributeProducts.sh
#  WhiteLabel
#
#  Created by Александр Клёмин on 19.09.2020.
#  Copyright © 2020 DIALOG. All rights reserved.

rm -rf "$PROJECT_DIR/$PRODUCT_NAME.framework"
cp -r "$CONFIGURATION_BUILD_DIR/$CONTENTS_FOLDER_PATH" "$PROJECT_DIR/$PRODUCT_NAME.framework"
rm "$PROJECT_DIR/$PRODUCT_NAME.framework/DistributeProducts.sh"

dialog_ios="Dialog_iOS"

pushd "$PROJECT_DIR/$PRODUCT_NAME.framework/Frameworks/$dialog_ios.framework" > /dev/null
zip -q "$dialog_ios.zip" "$dialog_ios"
rm "$dialog_ios"
popd > /dev/null
