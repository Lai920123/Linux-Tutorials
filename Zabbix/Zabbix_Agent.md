# Zabbix Agent #

## 安裝Zabbix Agent ##

### Debian ###

```bash
#安裝套件源
wget https://repo.zabbix.com/zabbix/6.2/debian/pool/main/z/zabbix-release/zabbix-release_6.2-1%2Bdebian11_all.deb
dpkg -i zabbix-release_6.2-1+debian11_all.deb
#更新套件源
apt update 
#安裝Zabbix Agent
apt install zabbix-agent
#開啟Zabbix Agent
systemctl enable --now zabbix-agent.service
```

### RHEL ###

```bash
#加入套件源
rpm -Uvh https://repo.zabbix.com/zabbix/6.2/rhel/9/x86_64/zabbix-release-6.2-2.el9.noarch.rpm
#清除快取
dnf clean all 
#安裝Zabbix Agent
dnf -y install zabbix-agent
#開啟Zabbix Agent
systemctl enable --now zabbix-agent.service
```
