# Service

## 建立自己的daemon

### 編輯設定檔

```bash
#使用vim編輯
vim /lib/systemd/system/nginx.service
#編輯以下內容
[Unit]
Descripton=nginx #描述
After=network.target #服務類別

[Service] #關於開機、重載、停止必須使用絕對路徑
Type=forking #於後台運行
ExecStart=/usr/local/nginx/sbin/nginx #開啟
ExecReload=/usr/local/nginx/sbin/nginx -s reload #重載
ExecStop=/usr/local/nginx/sbin/nginx -s quit #停止
PrivateTmp=true

[Install]
WantedBy=multi-user.target
```