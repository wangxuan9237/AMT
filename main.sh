#!/bin/bash
#
# This shell script ATM is writen by wangxuan.
# ATM0.1 first released at 2015/7/21.
# The aim is to analyses the web log /var/log/httpd/access_log.
# The results will mail to root. 
#
#Analyses items:
# 		 1.Page View
#
# I will add more functions later.
#
##################################################################
# INSTALL
#
# 1.creat work directory
#	mkdir /usr/local/logfile
#	tar -zxvf ATM-0.1.tgz -C /usr/local/logfile
#	chmod 755 /usr/local/logfile/ATM0.1.sh
#	chown root:root /usr/local/logfile/ATM0.1.sh
#
# 2.replace some parameters
#	email=...
#	
# 3.rewrite the crontab
#	vi /etc/crontab
#		0 0 * * * root /usr/local/logfile/ATM0.1.sh > /dev/null 2>&1
#
#=====================================================================
# History Records
# Date and writer             Item
#---------------------------------------------------------------------
# 2015/7/21 wangxuan          PV summary
#
#
#---------------------------------------------------------------------



#######################################################################
# Parameters

#email="wangxuan9237@163.com"
email="wangxuan"
basedir="/usr/local/logfile/"

# Check the Environment
which awk > /dev/null 2>&1
if [ "$?" != "0" ];then
	echo -e "No awk in your environment"|
	mail -s "WARNING" $email
	exit
fi


which sed > /dev/null 2>&1
if [ "$?" != "0" ];then
	echo -e "No sed in your environment"|
	mail -s "WARNING" $email
	exit
fi


service sendmail status > /dev/null 2>&1
if [ "$?" != "0" ];then
	echo -e "No start sendmail in your environment"|
	mail -s "WARNING" $email
	exit
fi

########################################################################
#
# version and logmail

versions="0.1"
logfile="$basedir/logfile.mail"

#######################################################################

echo "##########################################">$logfile
echo "Welcome use the ATM script"               >>$logfile
echo "Version:$versions"                        >>$logfile
echo "If you have any question,contack me!"     >>$logfile
echo "My blog:http://www.zifeiyu.pw"            >>$logfile
echo "#########################################">>$logfile
echo "    "                                     >>$logfile
echo "    "                                     >>$logfile


sh /usr/local/logfile/sys.sh                    >>$logfile
sh /usr/local/logfile/pv.sh                     >>$logfile

# send mail to root.
mail -s "Results of ATM$versions" $email        < $logfile                  
