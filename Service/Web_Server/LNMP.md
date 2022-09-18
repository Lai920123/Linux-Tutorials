# LNMP

## 套件安裝

```bash
#更新套件庫，才能下載較新的套件
apt update
#下載nginx，使用apt
apt -y install nginx
#原始碼安裝
tar zxvf nginx-1.22.0.tar.gz
cd nginx-1.22.0
./configure 
make
make install 
#下載mariadb
apt -y install mariadb-server
#下載php
apt -y install php
```