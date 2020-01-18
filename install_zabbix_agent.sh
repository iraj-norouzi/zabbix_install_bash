#!/bin/bash
yum install -y https://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-release-4.0-1.el7.noarch.rpm
yum install zabbix-agent -y
cp -rp  /etc/zabbix/zabbix_agentd.conf  /etc/zabbix/zabbix_agentd.conf.default
sed -e 's/Server=127.0.0.1/Server=10.11.12.99/' -e 's/ServerActive=127.0.0.1/ServerActive=10.11.12.99/' /etc/zabbix/zabbix_agentd.conf.default > /etc/zabbix/zabbix_agentd.conf

systemctl restart zabbix-agent
systemctl enable zabbix-agent
sudo firewall-cmd --add-port={10051/tcp,10050/tcp} --permanent
sudo firewall-cmd --reload

exit 0


# install zabbix postgresql monitoring
rpm -Uvh https://repo.zabbix.com/zabbix/4.0/rhel/7/x86_64/zabbix-agent-4.0.6-1.el7.x86_64.rpm
yum install -y libconfig
rpm -Uvh http://cdn.cavaliercoder.com/libzbxpgsql/yum/zabbix32/rhel/7/x86_64/libzbxpgsql-1.1.0-1.el7.x86_64.rpm
mkdir -p /var/lib/zabbix/modules/
ln -s /usr/lib64/zabbix/modules/libzbxpgsql.so /var/lib/zabbix/modules/libzbxpgsql.so

# install disk performance
#mkdir -p /etc/zabbix/zabbix_agentd.d/
#wget https://raw.githubusercontent.com/grundic/zabbix-disk-performance/master/userparameter_diskstats.conf -O /etc/zabbix/zabbix_agentd.d/userparameter_diskstats.conf
#wget https://raw.githubusercontent.com/grundic/zabbix-disk-performance/master/lld-disks.py -O /usr/local/bin/lld-disks.py
#chmod +x /usr/local/bin/lld-disks.py

