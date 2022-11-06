# journalctl

systemd-journal為systemd的logging機制，記錄所有來自kernel和user的log，並集中管理 

## 設定檔位置 ##

    /etc/systemd/journald.conf 

## 編輯設定檔 ##

Storage這個參數較為重要，預設為volatile，只會儲存在/run/log/journal/重開機後會消失，所以若是需要重開機也會記錄之前的log的話，需要將volatile更改為persistent,才會將資料寫入/var/log/journal/

```bash
[journal] 
Storage=persistent
#變更之後需要重啟服務 
systemctl restart systemd-journald
```

## 指令用法 ##

```bash
journalctl 
參數 
    -u [service name] 查詢指定服務的log 
    -k 列出kernel訊息,與dmesg相同
    –list-boots 列出每次開機的journal清單,0為本次,-1為上次,-2為上上次
    -p [log-level] 依照log level列出對應的log 
    0:emerg 
    1:alert 
    2:cirt 
    3:err 
    4:warning 
    5:notice 
    6:info 
    7:debug
```