# Repository

Repository(套件庫)是用來在安裝軟體時,會去查詢此套件庫,從此套件庫中安裝所要的軟體 

## Debian

Debian套件管理工具為apt和dpkg

### 套件庫設定檔

```bash
#查看設定檔內容
cat /etc/apt/source.list 
#預設會看到類似以下的設定(依照實際為準)
deb http://deb.debian.org/debian/ bullseye main contrib non-free
deb-src http://deb.debian.org/debian/ bullseye main contrib non-free
#各個欄位的意思
deb - 定義binary軟體包
deb-src - 定義Source code軟體包
#Repository URL
套件庫路徑，可指定ftp、http
#Distribution
stable - Debian官方最近一次發行的套件，為官方正式發行版本，建議使用bullseye替代stable，避免下個版本釋出時出現錯誤
unstable - Debian現行開發工作，較不穩定，通常適用於開發者 版本號為sid
testing - 暫時未被收錄進stable的套件，但版本較新，版本號為bookworm
#Component
main - 遵從Debian自由軟體引導方針，並不依賴於non-free的套件
contrib - 遵從Debian自由軟體引導方針，但依賴於non-free的套件
non-free - 不遵從Debian自由軟體引導方針的套件
###記得修改任何設定後先執行apt update在開始安裝套件，否則跳出找不到是正常的###
```

### 使用光碟安裝套件 ##

```bash
#查看光碟位置，一般在/media底下
ls /media/
cat /etc/fstab
mount
#將光碟加入source.list中，假如光碟在/media/cdrom0
apt-cdrom add /media/cdrom0
#查看是否成功加入
cat /etc/apt/source.list
```

### 列出已安裝的套件

```bash
apt list
```

### 更新套件庫

```bash
apt update
```

### 更新軟體

```bash
apt upgrade
```

### 安裝套件

```bash
#從網路伺服器中安裝套件，會連依賴的套件一同安裝
apt -y install <套件名稱>
#安裝本地套件的，不會連同依賴的套件一同安裝，附檔名為.deb
dpkg -i <*.deb>
apt -y install <*.deb>
```

### 刪除套件 ###
```bash
#移除此套件，但不會移除相依套件
apt remove <套件名稱>
#移除此套件和相依套件
apt autoremove <套件名稱>
#移除設定檔
apt purge <套件名稱>
#移除套件,相依套件和設定檔
apt autoremove --purge <套件名稱>
```
### 檢查套件有沒有安裝

```bash
dpkg -l | grep <要檢查的套件>
```

### 清除快取

```bash
apt clean
```

## CentOS

CentOS套件管理工具為yum和rpm，套件庫設定檔位於/etc/yum.repos.d/，副檔名為repo ，基本的套件有兩種BaseOS和AppStream，也有一種較新的套件管理工具為dnf,套件庫設定檔與yum相同都在/etc/yum.repos.d/

```bash
#預設會將下載後的套件包放在/var/cache/apt/archlives中，可以刪除目
#錄下的內容，或者使用以下指令清除
apt clean
```

### 自訂套件來源

```bash
[AppStream] 
name=App Stream #描述 
baseurl=https://dywang.csie.cyut.edu.tw/centos8/AppStream #來源網址 
gpgcheck=0 #gpg簽章是否要開啟,1開啟0關閉 
[BaseOS] name=Base OS #描述 
baseurl=https://dywang.csie.cyut.edu.tw/centos8/BaseOS #來源網址 
gpgcheck=0 #gpg簽章是否要開啟,1開啟0關閉
```

### 加入第三方套件源 ###

```bash
rpm -Uvh https://test.com/test/
```


### 檢查套件庫

```bash
yum list
dnf list
```

### 清除快取

```bash
yum clean all
dnf clean all
```

### 檢查套件有沒有安裝

```bash
rpm -qa | grep
```

### 清除快取

```bash
#預設會將下載後的套件包放在/var/cache/dnf或/var/cache/yum下，可
#以將目錄下的檔案刪除或者使用以下指令
dnf clean all
```

## GPG Key管理

加入第三方套件庫或者其他套件源時需要匯入gpg金鑰，否則使用apt update進行更新時就會因無法驗證而跳出錯誤

### 安裝GnuPG

```bash
apt -y install gnupg
```

### 下載公鑰

```bash
#Ubuntu
gpg --keyserver keyserver.ubuntu.com --recv AABBCCDD #key的末八碼，跳錯時會顯示
#Debian
gpg --keyserver keyring.debian.org --recv-keys AABBCCDD #key的末八碼，跳錯時會顯示
#CentOS
https://www.centos.org/keys/#how-centos-uses-gpg-keys
```