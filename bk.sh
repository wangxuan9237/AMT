#!/bin/bash
#use MySql back up every week.

USER="root"
PASSWD="w1990327"
MAIL="root"
DATE=`date +%m%d%y`
DATABASES="wp_wangxuan"
BKDIR="/root/mysql_bk"
LOGFILE="/root/mysql_bk/mysqlbk_log"
BKNAME="wp_wangxuan$DATE.bk"
BKFILE="$BKDIR/$BKNAME"
TARFILE="$BKNAME.tgz"
REMOTEIP="162.211.227.102"
PORT="28849"
REMOTEUSER="root"
REMOTEDIR="/root/mysql_bk"
netstat -tulnp | grep "mysqld" > /dev/null 2>&1
if [ "$?" != "0" ];then
	echo "mysqld no start"|\
	mail -s "WARNING" $MAIL
	exit
fi

if [ ! -d $BKDIR ];then
	mkdir -p $BKDIR
fi

echo " "                                 >$LOGFILE
echo "---------------------------------">>$LOGFILE
echo "`date`"                           >>$LOGFILE
echo "This file is mysql back up log file.">>$LOGFILE
echo "---------------------------------">>$LOGFILE

cd $BKDIR
mysqldump -u $USER -p$PASSWD $DATABASES > "$BKNAME" 

if [ "$?" == "0" ];then
	tar -czvf $TARFILE $BKNAME      >>$LOGFILE
	echo "SUCCESS"                  >>$LOGFILE
	rm -rf $BKNAME
fi

scp -P 28849 $TARFILE $REMOTEUSER@$REMOTEIP:$REMOTEDIR > /dev/null 2>&1

if [ "$?" == "0" ];then
	echo "SUCCESS mv to remote host!">>$LOGFILE
fi
