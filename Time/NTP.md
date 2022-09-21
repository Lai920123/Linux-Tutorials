# NTP

Linux Network time protocol server

使用chrony來進行NTP設定，設定檔位於/etc/chrony.conf

## 編輯設定檔

```bash
vim /etc/chrony.conf 
#新增pool,iburst用來加速初始同步
pool ntp.lai.com iburst
```

## 重啟服務

```bash
systemctl restart chronyd.service 
```

## 開機時自動開啟

```bash
systemctl enable chronyd.service
```

## 追蹤ntp server

```bash
chronyc tracking
```

## 檢查是和哪一台ntp server同步

```bash
chronyc sources
```

## chronyd立即校時

### 先將chronyd關閉

```bash
systemctl stop chronyd 
chronyd -q “pool  iburst”
```