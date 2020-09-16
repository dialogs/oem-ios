#!/bin/zsh

function help {
  echo 'Usage: source UploadPodsToAWS.sh \
    --accessKey <awsAccessKey> \
    --secretKey <awsSecretKey> \
    --version <versionNumber> \
    --build <buildNumber>'

  exit 1
}




zparseopts -E -- -accessKey:=storage
access_key=("${(@)storage:#--accessKey}")

zparseopts -E -- -secretKey:=storage
secret_key=("${(@)storage:#--secretKey}")

zparseopts -E -- -version:=storage
version_number=("${(@)storage:#--version}")

zparseopts -E -- -build:=storage
build_number=("${(@)storage:#--build}")

if
  [ -z "$access_key" ] ||
  [ -z "$secret_key" ] ||
  [ -z "$version_number" ] ||
  [ -z "$build_number" ]
then
  echo "Lack of arguments."
  help
fi




base_directory="$(dirname "$0")"

pods_archive="$base_directory/../Pods.zip"
podfile_lock="$base_directory/../Podfile.lock"

aws_cli_package="AWSCLIV2.pkg"

curl "https://awscli.amazonaws.com/$aws_cli_package" -o "$aws_cli_package"
sudo installer -pkg "$aws_cli_package" -target /
rm -f "$aws_cli_package"

export PATH="$PATH:/usr/local/bin"
export AWS_ACCESS_KEY_ID="$access_key"
export AWS_SECRET_ACCESS_KEY="$secret_key"

aws s3 cp "$pods_archive" "s3://dialog-ios-cdn/OEM/$version_number/$build_number/$pods_archive" --acl public-read

if [ $? -ne 0 ]; then
  exit $?
fi

aws s3 cp "$podfile_lock" "s3://dialog-ios-cdn/OEM/$version_number/$build_number/$podfile_lock" --acl public-read

if [ $? -ne 0 ]; then
  exit $?
fi
