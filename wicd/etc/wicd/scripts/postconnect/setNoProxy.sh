#!/bin/sh

IP=`/sbin/ifconfig  |
  grep 'inet addr:'|
  grep -v '127.0.0.1' |
  grep -v '172.17.0.1' |
  cut -d: -f2 |
  awk '{ print $1}'`

case $IP in
  15.150.*)
    logger "setNoProxy.sh -set NoProxy for enterprise net"
    NoProxy="NoProxy localhost, 127.0.0.*, 10.*, 192.168.*, enterprise-intranet, *.igrupobbva"
    ;;
  *)
    logger "setNoProxy.sh - set NoProxy for direct net"
    NoProxy="NoProxy *"
    ;;
esac

sed "s/^NoProxy.*$/$NoProxy/g" -i /etc/cntlm.conf
service cntlm restart
