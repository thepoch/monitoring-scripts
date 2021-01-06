#!/bin/bash
CONFIG=`dirname $0`/monitorvars.conf
if [ -f $CONFIG ]; then
	. $CONFIG
else
	echo "ERROR: Configuration file ${CONFIG} not found."
	exit 1
fi

SUBJECT="`hostname`: high load last 15 minutes"
MAXLOAD=`grep "processor" /proc/cpuinfo | wc -l`
UPTIMEFILE="/tmp/uptime"

uptime > $UPTIMEFILE
CURRENTLOAD=`cat /proc/loadavg | cut -f3 -d" " | cut -f1 -d.`

if [ $CURRENTLOAD -gt $MAXLOAD ]; then
	mail -s "$SUBJECT" $TO < $UPTIMEFILE
fi
