#!/bin/bash
CONFIG=`dirname $0`/monitorvars.conf
if [ -f $CONFIG ]; then
	. $CONFIG
else
	echo "ERROR: Configuration file ${CONFIG} not found."
	exit 1
fi

MAXUSAGE=80
SUBJECT="`hostname`: disk usage greater than $MAXUSAGE%"
DISKUSAGEFILE="/tmp/diskusage"

df -h > $DISKUSAGEFILE
CURRENTUSAGE=`df $DISKPART | awk '{print $5}' | sed -ne 2p | cut -d"%" -f1`

if [ $CURRENTUSAGE -gt $MAXUSAGE ]; then
	mail -s "$SUBJECT" $TO < $DISKUSAGEFILE
fi
