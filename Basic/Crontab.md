# crontab

Linux系統可以使用crontab或者是systemd.timer來進行工作排程

每個使用者都可以自訂排程工作,所以要依照每個使用者設定專屬的排程 !!!!!注意,在排程之前要注意時間問題 

## 目前使用者的crontab查詢

```
 crontab -l 
```

## 編輯

```
crontab -e 
```

## 刪除

```
crontab -r 
```

## 指定使用者的crontab查詢

```
crontab -l -u user001
```

## 編輯指定使用者

```
crontab -u  -e user001
```

## 刪除

```
crontab -r -u user001
```

## 個人crontab設定欄位

```
SHELL=/bin/bash #使用哪個shell
PATH=/sbin:/bin:/usr/sbin:/usr/bin #指令位置 
MAILTO=root #將執行程式輸出以Email送給使用者,若無可以使用""
```

```
* * * * * date
| | | | | |---------------- 要執行的指令
| | | | |------------------ 星期
| | | |-------------------- 月份
| | |---------------------- 日期
| |------------------------ 小時 0~23 記得要寫0
|-------------------------- 分鐘
特殊符號意思
*  任意時刻
,  不同時間點,例如12:00,01:00,03:00分別要執行同一指令就可以以","分隔
/n n為數字,例如在第一個欄位寫成*/1就代表每一分鐘執行一次
```

## 系統crontab設定欄位

```
SHELL=/bin/bash #使用哪個shell
PATH=/sbin:/bin:/usr/sbin:/usr/bin #指令位置
MAILTO=root #將執行程式輸出以Email送給使用者,若無可以使用""
```

## 與個人設定不同的只有多了USER這個欄位

```
* * * * * root date
| | | | | |    |---------------- 要執行的指令
| | | | | | ----------------- 使用者名稱
| | | | |-------------------- 星期
| | | |---------------------- 月份
| | |------------------------ 日期
| |-------------------------- 小時 0~23 記得要寫0
|---------------------------- 分鐘
特殊符號意思
*  任意時刻
,  不同時間點,例如12:00,01:00,03:00分別要執行同一指令就可以以","分隔
/n n為數字,例如在第一個欄位寫成*/1就代表每一分鐘執行一次
```

設定檔位於/etc/crontab和/etc/cron.d/底下 

## 特殊排程

```
@reboot 重開機後執行一次 
@yearly 每年執行一次 
@annually 每年執行一次 
@monthly 每月執行一次 
@weekly 每周執行一次 
@daily 每天執行一次 
@hourly 每小時執行一次
```

以上特殊排程直接寫並加上指令就好

例如 

```
@reboot date
```

限制使用者使用crontab

設定檔位於/etc/cron.allow(白名單)以及/etc/cron.deny(黑名單) 

若兩者都不存在,則只有root可以使用crontab

log檔 /var/log/cron 

紀錄crontab執行日誌的文件 

/var/spool/mail/username 

紀錄crontab執行失敗的log,對應到crontab檔案的PATH

檢查服務啟動 

## 啟動

```
systemctl status crond 
```

## 重新啟動

```
systemctl restart crond
```

systemd.timer: