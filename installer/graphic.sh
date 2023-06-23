#!/bin/bash
whiptail --colors --title "BitNinja for ARM64 [BETA]" --menu "Choose an option" 25 78 16 --colors "1;33;40"\
"<-- Back" "Return to the main menu." \
"Add User" "Add a user to the system." \
"Modify User" "Modify an existing user." \
"List Users" "List all users on the system." \
"Add Group" "Add a user group to the system." \
"Modify Group" "Modify a group and its list of members." \
"Exit" "Exit the installer"