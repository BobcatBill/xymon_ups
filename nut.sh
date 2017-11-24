#!/bin/bash

#HOSTLIST=$(/usr/lib/xymon/server/bin/xymongrep --no-down ups | awk '{print $2}')
#for HOST in $HOSTLIST ; do
	COLOR=green
	RESULT=$(/usr/local/bin/upsc ups | grep -E "battery.charge:|battery.runtime:|battery.voltage:|input.voltage:|ups.load:|ups.status:" | awk '{if($0~/^battery.runtime/){printf("%s %.1f\n",$1,$2/60)}else{print $1,$2}}')
	STATUS=$(echo "$RESULT" | grep ups.status | awk '{print $2}')
	CHARGE=$(echo "$RESULT" | grep battery.charge | awk '{print $2}')
	RUNTIME=$(echo "$RESULT" | grep battery.runtime | awk '{print $2}')
	BATTVOLT=$(echo "$RESULT" | grep battery.voltage | awk '{print $2}')
	INVOLT=$(echo "$RESULT" | grep input.voltage | awk '{print $2}')
	LOAD=$(echo "$RESULT" | grep ups.load | awk '{print $2}')
	if [ "$STATUS" != "OL" ] ; then
		COLOR=red
		UPS_STATE="Not Online"
	else
		UPS_STATE="Online"
	fi
	$XYMON $XYMSRV "status `hostname`.ups $COLOR `date` `echo "
UPS is $UPS_STATE
Battery Charge: $CHARGE %
Runtime Remaining: $RUNTIME minutes
Battery Voltage: $BATTVOLT VDC
Input Voltage: $INVOLT VAC
Load: $LOAD %"`
"
#done
