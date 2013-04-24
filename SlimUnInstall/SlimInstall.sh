#!/bin/bash
# By Brian Fisher <brifish@yahoo.com> 2013


# display menu
ShowMenus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo
	echo "This script will either install or un-install"
	echo "the SLIM Graphical Login Manager"
	echo "to run automatically when the system boots up"
	echo
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "1. Install Slim (disable confconsole)"
	echo "2. Un-install Slim (re-enable confconsole)"
	echo "3. Exit"
}

# read input from the keyboard and take a action
ReadOptions(){
	local choice
	read -p "Enter choice [1-3] " choice
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
	

	# install the slim application package
	sudo /usr/local/bin/InstallScript.sh Slim /usr/local/share/tkl/SlimInstall

}

UnInstallSlim(){

	echo To un-install, you need to use a sudo login.
	echo This is your normal user login password.
	echo

	# remove the slim application package
	sudo apt-get purge slim -y
	
	# re-initialize the confconsole interface on boot
	sudo update-rc.d confconsole defaults

	# Make the LXDE GUI start automatically when ‘admin’ logs in
	echo startx >> /home/admin/.bashrc
	
	Done

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


# -----------------------------------
# Main logic
# ------------------------------------
ShowMenus
ReadOptions

