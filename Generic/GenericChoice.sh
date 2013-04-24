#!/bin/bash
# By Brian Fisher <brifish@yahoo.com> 2013


Description="This script will either install or un-install the SLIM Graphical Login Manager to run automatically when the system boots up";

# ----------------------------------
# User defined functions
# ----------------------------------


PrintDescription(){
	clear
	echo
	echo "$Description"
	echo
}


ConfirmOrExit(){
	while true
	do
		read -p "Please confirm that you'd like to continue (Y/N) :" CONFIRM
		case $CONFIRM in
			y|Y|YES|yes|Yes) break ;;
			n|N|no|NO|No)
				Nope
				;;
			*) echo Please enter only y or n
		esac
	done
	echo You entered \'$CONFIRM\'. Continuing ...
}


Done(){
	echo
	echo "Your install-uninstall request has completed."
	read -p "Press the  [Enter] key to finish..." fackEnterKey
	exit 0
}


Nope(){
	echo
	echo "You chose not to continue";
	read -p "Press the [Enter] key to finish..." fackEnterKey
	exit 0
}

 
# function to display menus
ShowMenus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo
	echo "Would you like to install or un-install Slim?"
	echo
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "1. Install Slim (disable confconsole)"
	echo "2. Un-install Slim (re-enable confconsole)"
	echo "3. Exit"
}

# read input from the keyboard and take a action
ReadOptions(){
	local choice
	read -p "Enter choice [1-2] " choice
	case $choice in
		1) InstallSlim;;
		2) UnInstallSlim;;
		3) Nope;;
		*) echo -e "${RED}Error...${STD}"
			Nope;;
	esac
}
 
 
InstallSlim(){
	
	echo To install, you need to use a sudo login.
	echo This is your normal user login password.
	echo
	sudo /usr/local/bin/InstallScript.sh Slim /usr/local/share/tkl/SlimInstall.tar.gz
	
	Done

}

UninstallSlim(){

	echo To install, you need to use a sudo login.
	echo This is your normal user login password.
	echo
	sudo apt-get purge slim
	sudo update-rc.d confconsole defaults
	
	Done

}


# -----------------------------------
# Main logic
# ------------------------------------
PrintDescription
ShowMenus
ReadOptions


