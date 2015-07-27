#!/bin/bash

echo "==================sys info================"
echo "kernel version  :`cat /proc/version |\
      awk '{print  $3 }'`"                      
echo "CPU `cat /proc/cpuinfo | grep "model name"`"           
echo " "
echo "Memory Info:"                              
free -m                                         
echo " "
echo "Disk Info:"                               
df -h           
echo " "                                
echo "Linux services:"                          
netstat -tlnp | awk '{print $7}' | grep -v "Address"
echo "========================================="

