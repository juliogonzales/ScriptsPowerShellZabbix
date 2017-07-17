#!/bin/bash
date=$(date +"%d-%m-%Y - %H:%M")

 if pgrep "zabbix_proxy" > /dev/null
 then
 #       echo "=============================================== " >> /var/log/zabbix/watchdog.log
 #       echo "Zabbix Server esta UP - $date" >> /var/log/zabbix/watchdog.log
 #       echo " "  >> /var/log/zabbix/watchdog.log
         echo "OK"
 else
         echo "=============================================== " >> /var/log/zabbix/watchdog.log
         echo "Zabbix Server esta DOWN - $date" >> /var/log/zabbix/watchdog.log
         /usr/local/sbin/zabbix_agentd
         /usr/local/sbin/zabbix_proxy
         echo " "  >> /var/log/zabbix/watchdog.log
         echo "Zabbix Server e Agent foram INICIADOS com Sucesso! - $date" >> /var/log/zabbix/watchdog.log
         echo " "  >> /var/log/zabbix/watchdog.log
         echo "=============================================== " >> /var/log/zabbix/watchdog.log

 fi
