# Blink-IP
Blink the last octect of your IP on your headless Raspberry Pi

This script allows to use the on-board LEDs of the Raspberry Pi to "display" the last octect of the IP address that the Pi has received via DHCP.
It is generally know what the subnet of the network to which your are connecting your Raspberry Pi is. It's often in the form 192.168.0.x or 192.168.1.x but can obviously be any of the ones specified in [RFC 1918](https://tools.ietf.org/html/rfc1918).
If using a headless Pi it is therefore usefull most of the times to know the last octect of the IP.

For the Raspberry Pi A+,B+,2B and 3B the power LED is used whereas for the Raspberry Pi Zero the LED is the ACT.
This [links has additional details](https://www.jeffgeerling.com/blogs/jeff-geerling/controlling-pwr-act-leds-raspberry-pi) on how the LEDs are driven

The script blinks the digits of the fourth octect one by one starting from the leftmost digit first. It blinks the LED with brief intervals for digits from 1 to 9 and uses a long stable LED on for the 0.

A service and a log file are created by the install so that the script runs at boot time.
To stop the script once logged in execute:
```bash
sudo systemctl stop blink-ip.service
```
