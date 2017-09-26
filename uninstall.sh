#!/usr/bin/env bash

echo "Running this script will remove Blink-IP. If you are unsure of what this script does stop now."
read -p "Proceed? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  #Check if script is being run as root
  if [ "$(id -u)" != "0" ]; then
     echo "This script must be run as root" 1>&2
     exit 1
  fi
  
   InstallDir="/opt/blink-ip"
   rm -rf $InstallDir
   systemctl stop blink-ip.service
   systemctl disable blink-ip.service
   rm /etc/systemd/system/blink-ip.service
   
   whiptail --title "Uninstallation complete" --msgbox "Blink-IP has been disabled and removed. Please reboot your Raspberry Pi." 8 78
fi

