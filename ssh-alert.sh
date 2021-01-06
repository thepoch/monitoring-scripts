#!/bin/sh
CONFIG=`dirname $0`/monitorvars.conf
if [ -f $CONFIG ]; then
	. $CONFIG
else
	echo "ERROR: Configuration file ${CONFIG} not found."
	exit 1
fi

if [ "$PAM_TYPE" != "open_session" ]
then
	exit 0
else
	if [ "$PAM_RHOST" != "${IP}" ]
	then
	{
		echo "Date: `date`"
		echo "Remote Host: $PAM_RHOST"
		echo "User: $PAM_USER"
		echo "Service: $PAM_SERVICE"
		echo "Server: `hostname`"
	} | mail -s "$PAM_SERVICE login on `hostname` for user $PAM_USER from $PAM_RHOST" ${TO}
	fi
fi
exit 0
