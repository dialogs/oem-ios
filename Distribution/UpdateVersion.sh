#!/bin/zsh

zparseopts -E -- -version:=storage
version_number=("${(@)storage:#--version}")

zparseopts -E -- -build:=storage
build_number=("${(@)storage:#--build}")




plist_buddy="/usr/libexec/PlistBuddy"

function set_value_to_plist {
	command="Set $1 $2"
	$plist_buddy -c $command $3
}

function get_array_from_plist {
	command="Print $1"
	get_array_from_plist_result=($($plist_buddy -c $command $2 | sed -e 1d -e '$d'))
}




base_directory="$(dirname "$0")"

project="$base_directory/../Dialog.xcodeproj/project.pbxproj"

get_array_from_plist ":objects:ECEC373C24F8B9BD001FD1B9:buildConfigurations" "$project"

for project_configuration in $get_array_from_plist_result; do
	if [ ! -z "$version_number" ]; then
		set_value_to_plist ":objects:$project_configuration:buildSettings:MARKETING_VERSION" $version_number "$project"
	fi

	if [ ! -z "$build_number" ]; then
		set_value_to_plist ":objects:$project_configuration:buildSettings:CURRENT_PROJECT_VERSION" $build_number "$project"
	fi
done
