#!/bin/bash
# By Brian Fisher <brifish@yahoo.com> 2013


# display menu
ShowMenus() {
	clear
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo
	echo "This script can Remove/Add the Virtual Box folders"
	echo "from the TKLBAM backups for root and the admin user."
	echo "Not backing them up can save a lot of space because"
	echo "the Virtual Machine files are stored there."
	echo "If you do remove the VM files from TKLBAM,"
	echo "You can still run TKLBAM internally from the"
	echo "TKL virtual machines themselves."
	echo "This would back them up on their own TKLBAM IDs"
	echo
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "1. Do Not use TKLBAM  on the /Virtual VMs/ folders for root and admin"
	echo "2. Use TKLBAM  on the /Virtual VMs/ folders for root and admin"
	echo "3. Exit"
}

# read input from the keyboard and take a action
ReadOptions(){
	local choice
	read -p "Enter choice [1-3] " choice
	case $choice in
		1) NoBackupVMs;;
		2) YesBackupVMs;;
		3) Nope;;
		*) echo -e "${RED}Error...${STD}"
			Nope;;
	esac
}
 
 
NoBackupVMs(){

	echo To remove these from TKLBAM, you need to use a sudo login.
	echo This is your normal user login password.
	echo

	# Add any files/folders to exclude from TKLBAM backups here
	# Cache and executable files can be cut from backups
	# Setting VirtualBox to not backup the very large Virtual Machine files (the whole Virtual Disk) through TKLBAM
	# TKL Virtual Machines running in Virtual Box can use TKLBAM directly to back themselves up

	changefile="/etc/tklbam/overrides"

	search="/mnt/images"

	replace="\n\
-/root/VirtualBox?VMs/*\n\
-/home/admin/VirtualBox?VMs/*";

	# Create a check to see if this has already run on the file and exit if it has

	# Add the $replace folder to the TKLBAM overrides file to EXCLUDE it from being backed up
	sudo sed -i 's|'"$search"'|&'"$replace"'|' "$changefile"
	
	Done

}

YesBackupVMs(){
	
	# Remove the lines excluding the VirtualBox VM Folders
	# from the TKLBAM overrides file
	echo To add these to TKLBAM, you need to use a sudo login.
	echo This is your normal user login password.
	echo
	
	changefile="/etc/tklbam/overrides"
	
	search="-/root/VirtualBox?VMs/\*";

	# remove the first exclusion from TKLBAM
	sudo sed -i 's|'"$search"'||' "$changefile"


	search="-/home/admin/VirtualBox?VMs/\*";

	# remove the second exclusion from TKLBAM
	sudo sed -i 's|'"$search"'||' "$changefile"
	
	Done

}


Done(){
	echo
	echo "Your Add-Remove request has completed."
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

