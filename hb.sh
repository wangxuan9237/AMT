#!/bin/bash
#This script is about heartbeat fo httpd.
#Firt check the pid of httpd every 1min.

pgrep httpd >/dev/null 2>&1
if [ "$?" != "0" ];then
	echo "httpd has been dead!!!"|\
	mail -s "WARNING" root
fi

