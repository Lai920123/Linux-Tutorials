# Nginx #

>此文件撰寫時nginx版本為1.23.3

## 建立使用者和群組 ##

```bash
#建立使用者www，不允許登入但可使用服務
useradd -s /sbin/nologin www 
#建立群組www
groupadd www 
#將使用者www加入群組www
usermod -aG www www
```

## 安裝相依性套件 ##

Debian

```bash
apt -y install gcc #如果沒有裝gcc的話再裝
apt -y install make #如果沒有裝的話再裝
apt -y install zlib1g zlib1g-dev #用於gzip
apt -y install libpcre3 libpcre3-dev #用於rewrite
apt -y install openssl libssl-dev #用於SSL
```

CentOS

```bash
yum -y install gcc #如果沒有裝gcc的話再裝
yum -y install make #如果沒有裝的話再裝
yum -y install zlib #用於gzip
yum -y install pcre pcre-devel #用於rewrite
yum -y install openssl openssl-devel #用於SSL
```

## 使用原始碼安裝Nginx ##

官方下載路徑 http://nginx.org/en/download.html

```bash
#解壓縮
tar zxvf nginx-1.23.3.tar.gz 
#切換工作目錄至壓縮後的資料夾
cd nginx-1.23.3
#可設定編譯參數
./configure \ 
--user=www \ #啟動程序的使用者
--group=www \ #啟動程序的群組
--prefix=/usr/local/nginx \ #程式安裝路徑
--sbin-path=/usr/local/nginx/sbin/nginx \ #二進制檔案路徑
--conf-path=/usr/local/nginx/conf/nginx.conf \ #設定檔路徑
--error-log-path=/usr/local/nginx/logs/error.log \ #錯誤log路徑
--http-log-path=/usr/local/nginx/logs/access.log \ #存取紀錄log路徑
--pid-path=/var/run/nginx.pid \ #Nginx PID檔案路徑
--lock-path=/var/lock/subsys/nginx \ #lock檔案路徑
--with-openssl \ #指定openssl程式路徑
--with-http_stub_status_module \ #監視nginx狀態模組
--with-http_ssl_module \ #啟用nginx的openssl模組
--with-http_gzip_static_module \ #啟用gzip壓縮
--with-pcre #啟用正規表示法
#編輯、安裝
make
make install 
```

## 加入模組方法 ##

>若是在編譯時有模組少加，可使用以下方法加入模組

```bash
#查看上次配置時使用的參數
./usr/local/nginx/sbin/nginx -V
#複製參數再次configure，加上所需的模組參數
./configure --user=www --group=www --prefix=/usr/local/nginx --sbin-path=/usr/local/nginx/sbin/nginx --conf-path=/usr/local/nginx/conf/nginx.conf --error-log-path=/usr/local/nginx/logs/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/lock/subsys/nginx --with-http_stub_status_module --with-http_ssl_module --with-http_gzip_static_module --with-pcre --with-stream 
#重新編譯
make 
make install 
```

## Nginx命令 ##

```bash
#開啟Nginx 
./usr/local/nginx/sbin/nginx
#關閉Nginx
cat /usr/local
kill <pid> 
#平滑重啟(不間斷服務)
kill -HUP <pid>
#查看設定檔是否有誤
./usr/local/nginx/sbin/nginx -t 
#查看Nginx版本及編譯資訊
./usr/local/nginx/sbin/nginx -V
```
