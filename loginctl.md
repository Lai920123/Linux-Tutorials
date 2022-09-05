# loginctl

loginctl控制systemd登入管理器,可以管理當前登入的用戶以及session 

安裝 

```
dnf -y install systemd
```

開啟服務 

```
systemctl start systemd-logind.service
```

查看session

```
loginctl list-sessions 
```

預設執行loginctl和loginctl list-sessions效果是一樣的

顯示單一session的詳細信息

```
loginctl show-session 1000
```

斷開session

```
 loginctl kill-session 1000
```

session不會退出,但client的終端會停止動作

```
loginctl kill-session 1000 –signal=STGSTOP
```

列出使用者

```
loginctl list-users
```

查看當前使用者詳細訊息 

```
loginctl show-user user001
```

查看登入用戶的狀態 

```
loginctl user-status user001
```

結束指定用戶的所有session 

```
loginctl terminate-user user001
```

允許/禁止用戶逗留 

```
loginctl [enable-linger/disable-linger] user001 
```

如果指定了使用者或UID,系統將會在啓動時自動爲這些用戶派生出用戶管理器,並且 在用戶登出後繼續保持運行,這樣就可以允許未登錄的用戶在後臺運行持續時間很長的服務,如果沒有指定任何參數,那麼將用於當前調用的使用者。