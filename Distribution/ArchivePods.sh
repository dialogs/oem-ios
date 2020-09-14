#!/bin/zsh

base_directory="$(dirname "$0")"

zip -qry "$base_directory/../Pods.zip" "$base_directory/../Pods"
