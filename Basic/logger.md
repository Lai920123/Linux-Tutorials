# logger

logger指令用來操作syslog的系統日誌

## Syslog Factility

從哪個服務或設備傳來

| Kern | 核心訊息 |
| --- | --- |
| User | 使用者訊息 |
| Mail | 郵件訊息 |
| Dacmon | 未分類進程訊息 |
| Auth | 驗證訊息 |
| Syslog | Syslog本身訊息 |
| lpr | 列印訊息 |
| News | Usenet訊息 |
| UUCP | UUCP Server訊息 |
| Authpriv | 驗證訊息 |
| FTP | FTP Server訊息 |
| Crontab | 排程訊息 |
| Local0~7 | 本地訊息 |

## Syslog Severity

| * | 預設，將所有事件發送給Log Server |
| --- | --- |
| Emergency | 緊急，系統無法使用 |
| Alert | 警報，須立即修復 |
| Critical | 重要，情況嚴重 |
| Error | 錯誤，錯誤訊息 |
| Warning | 警告，不採取措施將會發生錯誤 |
| Notice | 注意，異常但不是錯誤 |
| Info | 資訊，一般操作訊息 |
| Debug | 除錯，須除錯的訊息 |

## 處理Log方式

```bash
#
```
## 參數

```bash
-d 使用UDP
-i 紀錄每一個log的pid
-f 紀錄特定文件
-n 指定log server
-P 使用指定的port
-p 指定優先級
-s 輸出標準錯誤至系統日誌
```

## 寫入文字至Syslog

```bash
logger "Hello"
#查看log
cat /var/log/messages
```

## 指定Log Server

```bash
#指定log server為10.1.1.100，並更改Port號為8888
logger -n 10.1.1.100 -P 8888
```