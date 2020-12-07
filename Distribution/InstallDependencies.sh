#!/bin/zsh

base_directory="$(dirname "$0")"

original="$base_directory/.."

export PATH="$PATH:/usr/local/bin"
export LANG="en_US.UTF-8"

cocoapods_version="1.9.3"

sudo gem install cocoapods -v "$cocoapods_version"
sudo gem install cocoapods-binary -v 0.4.4

pushd "$original" > /dev/null
rm -rf Pods
rm -f Podfile.lock
pod _"$cocoapods_version"_ cache clean --all
pod _"$cocoapods_version"_ install --repo-update

if [ $? -ne 0 ]; then
  exit $?
fi

popd > /dev/null
