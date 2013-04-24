#!/bin/bash
# By Brian Fisher <brifish@yahoo.com> 2013

 
# function to display menu
ShowMenus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo
	echo "This script will remove or add the server components"
	echo "of the core TKL appliance."
	echo "You may want to remove them to make your system"
	echo "more of a workstation than a server and to free up"
	echo "system resources."
	echo
	echo "You can also re-add them later with this script."
	echo
	echo "Which would you like to do?"
	echo
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "1. Remove Server Components"
	echo "2. Re-Add Server Components"
	echo "3. Exit - no change"
}

# read input from the keyboard and take a action
ReadOptions(){
	local choice
	read -p "Enter choice [1-3] " choice
	case $choice in
		1) RemoveServerComponents;;
		2) AddServerComponents;;
		3) Nope;;
		*) Nope;;
	esac
}
 
 
RemoveServerComponents(){


	echo "... Uninstalling the \"server\" parts of the TKL Workstation ..."
	echo
	echo " This includes Webmin, confconsole, shellinabox, byobu,"
	echo " and openssh-server."

	apt-get -y purge webmin* confconsole shellinabox byobu openssh-server 
	rm -Rf /usr/share/webmin
	
	# Need to add a .sh file to remove the components from a TKLBAM restore as well?
	
}



AddServerComponents(){
	
	echo "... Installing the \"server\" parts of the TKL Workstation ..."
	echo
	echo " This includes Webmin, confconsole, shellinabox, byobu,"
	echo " and openssh-server."

	apt-get -y install webmin* confconsole shellinabox byobu openssh-server 

	# Need to add a .sh file to restore the components from a TKLBAM restore as well?
	
}




Nope(){
	echo
	echo "You chose not to continue";
	read -p "Press the [Enter] key to finish..." AckEnterKey
	exit 0
}


# -----------------------------------
# Main logic
# ------------------------------------
PrintDescription
ShowMenus
ReadOptions


