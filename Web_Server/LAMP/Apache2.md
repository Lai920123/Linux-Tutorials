# apache2

先更新本地軟件包來下載最新版本 apt update 安裝apache2 apt -y install apache2

## HTTP

設定檔存在/etc/apache2

debian的配置檔案在/etc/apache2/apache2.conf

RedHat的配置檔案在/etc/httpd/conf/httpd.conf

動態模組設定檔

/etc/apache2/mods-enabled/*load

/etc/apache2/mods-enabled/*conf

監聽埠配置

/etc/apache2/ports.conf

虛擬主機配置

/etc/apache2/sites-enabled/ 存放每個html的設定檔

/etc/apache2/sites-available 存放允許的html設定檔(a2ensite打開的站台)

配置虛擬主機

vim /etc/apache2/sites-available/web1.it29.local.conf

```
<VirtualHost *:80>
    DocumentRoot /var/www/web1.it29.local                       #根目錄
    ServerName web1.it29.local                                  #FQDN
    ServerAdmin master@it29.local                               #管理員mail
    ErrorLog /var/log/apache2/virtual.host.error.log            #錯誤Log
    CustomLog /var/log/apache2/virtual.host.access.log combined #存取Log combined為格式
</VirtualHost>

<Directory "/var/www/web1.it29.local">
    Options FollowSymLinks
    AllowOverride All
</Directory>

```

開啟apache2站台

a2ensite web1.it29.local(若不知道可以先打a2ensite查看)

systemctl reload apache2

配置根目錄及網頁檔

mkdir /var/www/web1.it29.local

vim /var/www/web1.it29.local/index.html

## HTTPS

## 自簽憑證啟用https

安裝OpenSSL

apt -y install openssl

啟用apache2 ssl module

a2enmod ssl

重啟apache2

systemctl restart apache2

產生自我簽署憑證

修改Apache SSL Site設定

編輯/etc/apache2/sites-available/default-ssl.conf

vim /etc/apache2/sites-available/default-ssl.conf

指定SSLCertificateFile與SSLCertificateKeyFile路徑

#32~33

SSLCertificateFile /etc/apache2/CA.crt

SSLCertificateKeyFile /etc/apache2/server.key

啟用Apache SSL Site

a2ensite default-ssl.conf 重新載入Apache2服務

systemctl reload apache2

## 向CA申請憑證

產生主機私密金鑰

openssl genrsa -out server.key 2048

產生憑證請求檔

openssl req -new -key server.key -out server.csr

填寫資料

Country Name (2 letter code) [AU]:TW

State or Province Name (full name) [Some-State]:Taipei

Locality Name (eg, city) []:Taipei

Organization Name (eg, company) [Internet Widgits Pty Ltd]:it29

Organizational Unit Name (eg, section) []:sales

Common Name (eg, YOUR name) []:www.it29.local

Email Address []:.master@it29.local

Please enter the following ‘extra’ attributes

to be sent with your certificate request

A challenge password []:.

An optional company name []:.

要求憑證

![apache2%2088fdcf933d734236b5c2c1b6247720fb/Untitled.png](apache2%2088fdcf933d734236b5c2c1b6247720fb/Untitled.png)

Untitled

![apache2%2088fdcf933d734236b5c2c1b6247720fb/Untitled%201.png](apache2%2088fdcf933d734236b5c2c1b6247720fb/Untitled%201.png)

Untitled

複製憑證請求檔

進階憑證要求

![apache2%2088fdcf933d734236b5c2c1b6247720fb/Untitled%202.png](apache2%2088fdcf933d734236b5c2c1b6247720fb/Untitled%202.png)

Untitled

貼入並點選提交

![apache2%2088fdcf933d734236b5c2c1b6247720fb/Untitled%203.png](apache2%2088fdcf933d734236b5c2c1b6247720fb/Untitled%203.png)

Untitled

憑證識別碼為2,並等待CA發行憑證

![apache2%2088fdcf933d734236b5c2c1b6247720fb/Untitled%204.png](apache2%2088fdcf933d734236b5c2c1b6247720fb/Untitled%204.png)

Untitled

回到網頁註冊服務,可檢視擱置的憑證要求狀態

![apache2%2088fdcf933d734236b5c2c1b6247720fb/Untitled%205.png](apache2%2088fdcf933d734236b5c2c1b6247720fb/Untitled%205.png)

Untitled

![apache2%2088fdcf933d734236b5c2c1b6247720fb/Untitled%206.png](apache2%2088fdcf933d734236b5c2c1b6247720fb/Untitled%206.png)

Untitled

憑證已發行,下載憑證

![apache2%2088fdcf933d734236b5c2c1b6247720fb/Untitled%207.png](apache2%2088fdcf933d734236b5c2c1b6247720fb/Untitled%207.png)

Untitled

下載之後因cer為Windows Server IIS使用的格式,所以須使用openssl將格式轉為crt

openssl x509 -in server.cer -out server2.crt -inform DER

接著設定https檔

vim /etc/apache2/sites-available/defualt-ssl.conf

更改以下內容

ServerAdmin master@it29.local

DocumentRoot /var/www/www.it29.local

SSLCertificateFile 更改為剛剛載下來的憑證路徑

SSLCertificateKeyFile 更改為自己產生的私密金鑰路徑

若有中繼憑證則更改

SSLCertificateChainFile 中繼憑證路徑

配置完成後

開啟ssl模組

a2enmod ssl

開啟default-ssl站台

a2ensite defualt-ssl

## 架設CA服務

## TroubleShooting

AH00558:apache2:Could not reliably determine the server’s fully qualified domain name,using 127.0.1.1.Set the ‘ServerName’ directive globally to>

出現此錯誤需再apache2配置檔中加入ServerName

vim /etc/apache2/apache2.conf

ServerName www.it29.local:80