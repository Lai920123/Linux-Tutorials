# journalctl

systemd-journal為systemd的logging機制,記錄所有來自kernel 和user的log,並集中管理 

journal設定檔位於/etc/systemd/journald.conf 

Storage這個參數較為重要,預設為volatile,只會儲存在/run/log/journal/ 重開機後會消失,所以若是需要重開機也會記錄之前的log的話,需要將volatile 更改為persistent,才會將資料寫入/var/log/journal/,如下 

```
[journal] 
Storage=persistent
```

變更之後重啟服務 

```
systemctl restart systemd-journald
```

journalctl 

參數 

-u [service name] 查詢指定服務的log 

-p [log-level] 依照log level列出對應的log 

0:emerg 

1:alert 

2:cirt 

3:err 

4:warning 

5:notice 

6:info 

7:debug

 -k 列出kernel訊息,與dmesg相同

 –list-boots 列出每次開機的journal清單,0為本次,-1為上次,-2為上上次