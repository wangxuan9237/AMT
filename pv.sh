#!/bin/bash
WABFILE="/var/log/httpd/access_log"
HOSTIP="202.118.68.9"
#
#
#
#===========================top 5 of the pv IP================================
declare -i NL=`cat $WABFILE | awk '{print $1}' | sort | uniq | wc -l`
echo "=============top 5 of pv IP=============="
if [ "$NL" -lt "5" ];then
	cat $WABFILE | awk '{print $1}' | sort | grep -v "$HOSTIP" | uniq -c | sort -r
else 
	cat $WABFILE | awk '{print $1}' | sort | grep -v "$HOSTIP" | uniq -c | sort -r | head -n 5
fi
#===========================top 5 of the visit time===========================

echo "=============top 5 of visit time=========="
cat $WABFILE | awk '{print $4}' | cut -c 2- | sort | uniq -c | sort -r | head -n 5



#===========================top 5 of the visit page===========================
echo "=============top 5 of visit page==========="
awk '{print $11}' $WABFILE | sort | uniq -c | sort -r |head -n 5

#===========================sum of processes of httpd=========================
echo "=============sum of processes of httpd====="

NP=`ps aux | grep "httpd" | grep -v "grep" | wc -l`
echo "      $NP httpd processes are running on your server."
NE=`netstat -atulnp | grep 'httpd' | grep 'ESTABLISHED' | wc -l`
echo "      $NE have been established."
