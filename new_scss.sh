#!/bin/bash

# This script copies scss/defualt.scss and creates a new file (by default) based on the ZURB Foundation framework
# The SCSS file has two componates the scss/file_name.scss settings file, which imports all the moduals and is where you define global settings
# and the scss/custom/_file_name.scss where all custom attributes should go

set -o errexit

if [ -z "$1" ]
then

	echo -n "Please enter stylesheet name: "

	read scss_name_raw

else

	scss_name_raw=$1

fi

#turn whitespace to underscore
scss_name=${scss_name_raw// /_}

echo "Creating scss/$scss_name.scss ..."

verb='created'

if [ -e scss/$scss_name.scss ]
then
	echo -n "It appears scss/$scss_name.scss already exists, abort?[Y/n]:"
	read a
	if [[ $a == "N" || $a == "n" ]];
	then
	    echo "We'll carry on then..."
	    verb='overwritten'
	else
		echo "aborting"
		exit 123
	fi
fi

#copy default
cp scss/default.scss scss/$scss_name.scss
#create blank custom file
touch scss/custom/_$scss_name.scss
#add import call to new scss base file
echo "@import \"custom/_$scss_name.scss\"" >> scss/$scss_name.scss 

echo -e "Success the following files were $verb:\nscss/$scss_name.scss\nscss/custom/_$scss_name.scss\n\nSimply add 'css: $scss_name' to the YAML header of your template"