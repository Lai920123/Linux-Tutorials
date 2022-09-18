# LAMP

[apache2](LAMP%202b37d5f32a5f4eaa978e273cc84a89e1/apache2%2088fdcf933d734236b5c2c1b6247720fb.md)

## 套件安裝

```bash
#更新套件庫，才能下載較新的套件
apt update
#下載apache2
apt -y install apache2 
#下載mariadb
apt -y install mariadb-server
#下載php
apt -y install php
```

## 使用HTTPS

### 產生請求檔

```bash
#生成金鑰
openssl genrsa -out server.key 2048
#產生憑證請求檔，輸入以下指令之後再將各項資訊填完就會產生請求檔
openssl req -new -key server.key -out certreq.txt
-------------------------------------------------------
Country Name:國家
State or Province Name:州或省，台灣的話直接Enter就好
Locality Name:城市
Organization Name:組織名
Organization Unit Name:單位名
Common name:網站FQDN
Email address:電子郵件
challenge password:(可以省略，按Enter)
optional company name:(可以省略，按Enter)
```

### 申請憑證

打開瀏覽器，輸入https://server3.lai.com/certsrv(申請憑證的網址，實際的跟這裡不同)，點選Request a certificate

![Untitled](Nginx%20d7f5c7fc40134c1dbd202ace2ecf7055/Untitled.png)

Advanced certificate request

![Untitled](Nginx%20d7f5c7fc40134c1dbd202ace2ecf7055/Untitled%201.png)

貼上剛剛生成的請求檔，Certificate Template選擇Web Server，接著按Submit

![Untitled](Nginx%20d7f5c7fc40134c1dbd202ace2ecf7055/Untitled%202.png)

Download Certificate

![Untitled](Nginx%20d7f5c7fc40134c1dbd202ace2ecf7055/Untitled%203.png)

### 憑證格式轉換

因下載下來的憑證格式為cer，cer是Windows使用的格式，Linux發行版中需要將cer轉成crt

```bash
openssl x509 -in certnew.cer -out certnew.crt -inform DER
```