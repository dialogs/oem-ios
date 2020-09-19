#!/bin/zsh

base_directory="$(dirname "$0")"

pushd "$base_directory/.." > /dev/null
zip -qry "Pods.zip" "Pods"
popd > /dev/null
