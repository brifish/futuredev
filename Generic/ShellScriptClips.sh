#!/bin/bash
# By Brian Fisher <brifish@yahoo.com> 2013

if [ $# -ne 2 ]
then
	echo "Usage - $0 package-to-install path-to-patch.tar.gz"
	exit 1
fi

InstallPackage=$1
Patch=$2


# ----------------------------------
# User defined functions
# ----------------------------------
# Install patch file
Install(){
	echo
	echo "call \$ tklpatch-apply / $Patch"
	echo
	echo "The install of $InstallPackage has completed."
	read -p "Press the  [Enter] key to finish..." fackEnterKey
	exit 0
}


# No install selected
NoInstall(){
	echo
	echo "You chose to not install $InstallPackage";
	read -p "Press the [Enter] key to finish..." fackEnterKey
	exit 0
}

 
# function to display menus
show_menus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"	
	echo " Would you like to install $InstallPackage ?"
	echo " Enter 'y' to continue and install $InstallPackage"
	echo " Enter 'n' to exit without installing."
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "'y' Install $InstallPackage"
	echo "'n' Exit"
}

# read input from the keyboard and take a action
read_options(){
	local choice
	read -p "Enter choice [y-n] " choice
	case $choice in
		y) Install;;
		n) NoInstall;;
		*) echo -e "${RED}Error...${STD}"
			NoInstall;;
	esac
}
 
 

# -----------------------------------
# Main logic
# ------------------------------------
show_menus
read_options

