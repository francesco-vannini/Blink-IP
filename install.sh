#!/usr/bin/env bash

echo "Running this script will install Blink-IP. If you are unsure of what this script does stop now."
read -p "Proceed? " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
  #Check if script is being run as root
  if [ "$(id -u)" != "0" ]; then
     echo "This script must be run as root" 1>&2
     exit 1
  fi
  
  if [ ! $? = 0 ]; then
     exit 1
  else
     BlinkIPDir="Blink-IP"
     if [ -d "$BlinkIPDir" ]; then
          whiptail --title "Installation aborted" --msgbox "$BlinkIPDir already exists, please remove it and restart the installation" 8 78
          exit
     fi
  
     git clone https://github.com/francesco-vannini/Blink-IP.git
     InstallDir="/opt/blink-ip"
     mkdir $InstallDir
     cp $JustBoomDir/blink-ip.sh $InstallDir
     chmod 755 $InstallDir/blink-ip.sh
     touch $InstallDir/blink-ip.log
     chmod 644 $InstallDir/blink-ip.log
     cp $JustBoomDir/blink.service /etc/systemd/system
  
     systemctl enable blink-ip.service
     systemctl start blink-ip.service
     whiptail --title "Installation complete" --msgbox "Blink-IP installation complete. Please reboot your Raspberry Pi now." 8 78
  fi
fi
