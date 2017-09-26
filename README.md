# Blink-IP
Blink the last octect of your IP on your headless Raspberry Pi

This script allows to use the on-board LEDs of the Raspberry Pi to "display" the last octect of the IP address that the Pi has received via DHCP.
It is generally know what the subnet of the network to which your are connecting your Raspberry Pi is. It's often in the form 192.168.0.x or 192.168.1.x but can obviously be any of the ones specified in [RFC 1918](https://tools.ietf.org/html/rfc1918).
If using a headless Pi it is therefore usefull most of the times to know the last octect of the IP.

For the Raspberry Pi A+,B+,2B and 3B the power LED is used whereas for the Raspberry Pi Zero the LED is the ACT.
This [links has additional details](https://www.jeffgeerling.com/blogs/jeff-geerling/controlling-pwr-act-leds-raspberry-pi) on how the LEDs are driven

The script blinks the digits of the fourth octect one by one starting from the leftmost digit first. It blinks the LED with brief intervals for digits from 1 to 9 and uses a long stable LED on for the 0.

"-" ON time in 1/2 seconds
"." OFF time in 1/2 seconds
```
1 --.
2 --.--.
...
9 --.--.--.--.--.--.--.--.--.
0 ----------.
```
The ON duration is set to 1 second for 1-9 and 5 seconds for 0. The OFF duration is 0.5 seconds for all.
The script will start by turning the LED off for 5 seconds, blink the digits each separated by 3 seconds and eventually repeat in an endless loop the digits after a further pause of 10 seconds.

"=" 1 second
```
Script start ===== 1st Digit === 2nd Digit === 3rd Digit === ==========
                   ^--------------------------------------------------v
```

If the IP's fourth octect is less than three digits only one or two digits will be represented.

A service and a log file are created by the install so that the script runs at boot time.

## Install
Run this command to get the installation script
```bash
curl -sSL https://raw.githubusercontent.com/francesco-vannini/Blink-IP/master/install.sh -o install.sh
```
then execute
```bash
sudo bash install.sh
```
## Uninstall
Once the script has been used you might want to return the LEDs to their normal function.
You can uninstall the script by running
```bash
sudo bash ~/Blink-IP/uninstall.sh
```
