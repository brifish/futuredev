#!/bin/bash
# By Brian Fisher <brifish@yahoo.com> 2013


Description="This Script will set or reset the Desktop graphic and the Taskbar Menu Icon";

# ----------------------------------
# User defined functions
# ----------------------------------

LaunchUser=$USER

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
	echo "The desktop graphic and taskbar icon have been changed."
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
	echo "Which TKL Desktop graphic and taskbar icon would you like to use?"
	echo
	echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
	echo "1. Aurora"
	echo "2. Milky Way"
	echo "3. Supernova"
	echo "4. Honey"
	echo "5. Purple"
	echo "6. Default LXDE"
}


# read input from the keyboard and take a action
ReadOptions(){
	local choice
	read -p "Enter choice [1-13] " choice
	case $choice in
		1) DesktopWallpaper="/usr/share/lxde/wallpapers/tkl-client-aurora.jpg"
			StartIcon="/usr/share/lxde/images/lxde-TKLicon.png"
			SetGraphics;;
		2)  DesktopWallpaper="/usr/share/lxde/wallpapers/tkl-client-milkyway.jpg"
			StartIcon="/usr/share/lxde/images/lxde-TKLicon.png"
			SetGraphics;;
		3)  DesktopWallpaper="/usr/share/lxde/wallpapers/tkl-client-supernova.jpg"
			StartIcon="/usr/share/lxde/images/lxde-TKLicon.png"
			SetGraphics;;
		4)  DesktopWallpaper="/usr/share/lxde/wallpapers/tkl-honey.jpg"
			StartIcon="/usr/share/lxde/images/lxde-TKLicon.png"
			SetGraphics;;
		5)  DesktopWallpaper="/usr/share/lxde/wallpapers/tkl-purple.jpg"
			StartIcon="/usr/share/lxde/images/lxde-TKLicon.png"
			SetGraphics;;
		6)  DesktopWallpaper="/usr/share/lxde/wallpapers/lxde_blue.jpg"
			StartIcon="/usr/share/lxde/images/lxde-icon.png"
			SetGraphics;;
		*) echo -e "${RED}Error...${STD}"
			Nope;;
	esac
}
 
 
SetGraphics(){
	echo
	echo "setting Desktop wallpaper and taskbar icon to your selection"
	echo

	# sed edit the Desktop wallpaper config file	
	WallChangeFile="/home/$LaunchUser/.config/pcmanfm/LXDE.conf"

	WallPaperSearch="wallpaper=.*"

	WallPaperReplace="wallpaper=$DeskTopWallpaper"

	sed -i 's/'"$WallPaperSearch"'/'"$WallPaperReplace"'/' "$WallPaperChangeFile"
	
	
	# sed edit the taskbar icon config file
	IconChangeFile="/home/$LaunchUser/lxpanel/LXDE/panels/panel"

	IconSearch="image=/.*"

	IconReplace="image=$StartIcon"

	sed -i 's/'"$IconSearch"'/'"$IconReplace"'/' "$IconChangeFile"
	
	
	# restart the LXDE panel to display the change
	lxdepanelctl restart
	
	Done
}


# -----------------------------------
# Main logic
# ------------------------------------
PrintDescription
ConfirmOrExit
ShowMenus
ReadOptions

