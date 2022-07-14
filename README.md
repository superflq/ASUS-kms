#!/bin/sh
cd /jffs/

echo
netstat -an |grep 1688

mkdir /jffs/configs
touch /jffs/configs/dnsmasq.conf.add
chmod 0755 /jffs/configs/*
echo "srv-host=_vlmcs._tcp.lan,`uname -n`.lan,1688,0,100">>/jffs/configs/dnsmasq.conf.add

echo
service restart_dnsmasq
echo
iptables -I INPUT -p tcp --dport 1688 -j ACCEPT

mkdir /jffs/scripts
cd /jffs/scripts
wget "https://github.com/superflq/kms/blob/main/vlmcsd.t"
mv vlmcsd.t vlmcsd

touch /jffs/scripts/firewall-start
chmod 0755 /jffs/scripts/*

echo "#!/bin/sh">>/jffs/scripts/firewall-start
echo "/jffs/scripts/vlmcsd">>/jffs/scripts/firewall-start
echo "service restart_dnsmasq">>/jffs/scripts/firewall-start
echo "iptables -I INPUT -p tcp --dport 1688 -j ACCEPT">>/jffs/scripts/firewall-start
