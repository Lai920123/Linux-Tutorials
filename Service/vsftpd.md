# vsftpd

FTP會開啟兩個Port，分別為port 20和port 21，20用來傳送資料，21用來傳遞Client與Server間的指令

## 建立FTP登入目錄

```bash
mkdir /var/ftp-client
```

## 建立登入使用者

```bash
useradd -d /var/ftp-client -s /sbin/nologin ftp-client
```

## 編輯設定檔

```bash
#以下幾條需要更改
anonymous_enable=NO #不允許匿名登入
local_enable=YES #啟用一般帳號登入
write_enable=YES #允許對FTP檔案具有寫入權限
local_umask=022 #設定檔案掩碼
anon_upload_enable=YES #允許匿名使用者上傳檔案，須開啟write_enable
anon_mkdir_write_enable=YES #允許匿名使用者建立資料夾
xferlog_enable=YES #系統自動維護上傳和下載的紀錄檔
xferlog_file=/var/log/vsftpd.log #指定log檔案路徑
connect_from_port_20=YES #開啟資料連接埠的串連請求
chown_uploads=YES #可更改檔案擁有者和群組
chown_username=whoever #任何人都可更改檔案擁有者和群組
xferlog_std_format=YES #以標準格式紀錄log檔

```