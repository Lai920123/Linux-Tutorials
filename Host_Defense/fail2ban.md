# fail2ban

fail2ban是由python所寫的入侵檢測系統框架,可以保護電腦不受暴力破解攻擊 ,通常用於開啟ssh,ftp,telnet的主機上 

## 安裝fail2ban

```bash
#CentOS
yum -y install epel-release 
yum -y install fail2ban
#Debian
apt -y install fail2ban
```

## 編輯設定檔

路徑：/etc/fail2ban/jail.conf

為了避免更新時被覆蓋掉,所以另 外編輯一個jail.local檔案,並輸入以下內容 

```bash
#使用vim編輯
vim /etc/jail.local 
#寫入以下內容
ignoreip = 127.0.0.1/8 #白名單,多個IP以,分隔 
bantime = 86400 #ban多久時間，-1等於永久封鎖
findtime = 600 #多長時間內超過maxretry的次數就會封鎖 
maxretry = 5 #最大嘗試次數 
banaction = firewallcmd-ipset 
action = %(action_mwl)s 
backend = systemd desmail = root@gmail.com #將錯誤訊息寄給管理員mail
[sshd]
enabled = true #啟用 
filter = sshd #過濾sshd 
port = 22 
action = %(action_mwl)s 
logpath = /var/log/secure #log儲存路徑
```