#!/bin/sh
cd /jffs/
wget "https://github.com/superflq/kms/blob/main/vlmcsd.t"
mv vlmcsd.t vlmcsd
chmod 0755 vlmcsd
/jffs/vlmcsd
clear
echo 
netstat -an |grep 1688
echo 
touch /jffs/configs/dnsmasq.conf.add
chmod 0755 /jffs/configs/dnsmasq.conf.add
echo "srv-host=_vlmcs._tcp.lan,`uname -n`.lan,1688,0,100">>/jffs/configs/dnsmasq.conf.add

service restart_dnsmasq
iptables -I INPUT -p tcp --dport 1688 -j ACCEPT

touch /jffs/scripts/firewall-start
chmod 0755 /jffs/scripts/firewall-start
echo "#!/bin/sh">>/jffs/scripts/firewall-start
echo "/jffs/vlmcsd">>/jffs/scripts/firewall-start
echo "service restart_dnsmasq">>/jffs/scripts/firewall-start
echo "iptables -I INPUT -p tcp --dport 1688 -j ACCEPT">>/jffs/scripts/firewall-start