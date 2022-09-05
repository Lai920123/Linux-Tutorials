# PPTP

Point to Point Tunneling Protocol點對點隧道協定

範例使用Debian 

### 安裝套件

```bash
#Debian
sudo apt -y install pptpd
#CentOS
sudo yum -y install epel-release #先安裝第三方套件庫
sudo yum -y install ppp pptpd 

```

### 編輯設定檔

```bash
#設定檔位於/etc/pptpd.conf
vim /etc/pptpd.conf
#寫入以下內容，若是已經有了就把註解拿掉
option /etc/ppp/pptpd-options
#本機IP
localip 10.1.1.10 
#連線進來所能拿到的IP範圍
remoteip 10.1.1.100-199
```

### 新增登入使用者

```bash
#設定檔位於/etc/ppp/chap-secrets
vim /etc/ppp/chap-secrets
#新增以下內容，例如設定一登入使用者名為user001，密碼為test123
user001 pptpd "test123" *(選填，連線來源IP，*代表允許任何IP連接)
```

## Client