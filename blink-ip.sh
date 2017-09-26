#!/usr/bin/env bash

function blink_digit {
  if [ $1 -eq 0 ]; then
    onduration=5
    offduration=0.5
    reps=1
  elif [ $1 -gt 0 ] && [ $1 -lt 10 ]; then
    onduration=1
    offduration=0.5
    reps=$1
  fi

  if $2; then
    on=0
    off=1
    led="led0"
  else
    on=1
    off=0
    led="led1"
  fi

  for (( i=1; i<=$reps; i++ ))
  do
    echo $on | sudo tee /sys/class/leds/$led/brightness > null
    sleep $onduration
    echo $off | sudo tee /sys/class/leds/$led/brightness > null
    sleep $offduration
  done
}

revision=`cat /proc/cpuinfo | grep 'Revision' | awk '{print $3}'`
if [[ "9000" == ${revision:0:4} ]]; then
  isazero=true
else
  isazero=false
fi

ipe=`ifconfig eth0 2>/dev/null|awk '/inet / {print $2}'|sed 's/addr://'`
ipw=`ifconfig wlan0 2>/dev/null|awk '/inet / {print $2}'|sed 's/addr://'`
echo "IP address eth0: "$ipe
echo "IP address wlan0: "$ipw
ipeoct1=$(echo $ipe | cut -d'.' -f1)
echo "First octect of eth0: "$ipeoct1
ipwoct1=$(echo $ipw | cut -d'.' -f1)
echo "First octect of wlan0: "$ipwoct1

if [[ $ipeoct1 == "192" || $ipeoct1 == "172" || $ipeoct1 == "10" ]]; then
  eth0gotaddress=true
else
  eth0gotaddress=false
fi

if [[ $ipwoct1 == "192" || $ipwoct1 == "172" || $ipwoct1 == "10" ]]; then
  wlan0gotaddress=true
else
  wlan0gotaddress=false
fi

echo "wlan0 has a valid address: " $wlan0gotaddress
echo "eth0 has a valid address: " $eth0gotaddress

if $eth0gotaddress; then
  ipoct4=$(echo ${ipe} | tr "." " " | awk '{ print $4 }')
elif $wlan0gotaddress; then
  ipoct4=$(echo ${ipw} | tr "." " " | awk '{ print $4 }')
else
  echo "No cards found"
  exit
fi

if $isazero;then
  echo none | sudo tee /sys/class/leds/led0/trigger > null
else
  echo cpu0 | sudo tee /sys/class/leds/led1/trigger > null
fi

echo "Assuming it is a Pi Zero: " $isazero
echo "Fourth octect of the IP: " $ipoct4

sleep 5

while :
do
  for (( d=0; d<${#ipoct4}; d++ ))
  do
    digit=${ipoct4:$d:1}
    blink_digit $digit $isazero
    sleep 3
  done
  sleep 10
done

