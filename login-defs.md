# login-defs

linux對於新增使用者,有預設的密碼過期時間 設定檔位於/etc/login.defs,可以經由修改設定檔,變更預設的密碼過期時間與其他參數 

```
vim /etc/login.defs
```

```
PASS_MAX_DAYS 99999 密碼過期時間,,99999為永久不需要重新設定,設為0代表下次登入會過期,若過一段時間還未修改,就會失效 PASS_MIN_DAYS 0 密碼修改後,多久才可以重新修改(避免有人不斷修改) PASS_MIN_LEN 5 密碼最短長度 
PASS_WARN_AGE 7 密碼過期前多久會發出警告
UID_MIN 1000 UID開始編號 
UID_MAX 60000 UID最大編
SYS_UID_MIN 201 系統帳號開始UID編號 
SYS_UID_MAX 999 系統帳號最大UID編號
GID_MIN 1000 GID開始編號 
GID_MAX 60000 GID最大編號
SYS_GID_MIN 201 系統帳號開始GID編號 
SYS_GID_MAX 999 系統帳號最大GID編號
UMASK 077 預設家目錄的權限為rwx——
CREATE_HOME yes 建立家目錄
ENCRYPT_METHOD SHA512 使用者密碼加密方式
```

用指令設定特定使用者參數 使用chage這個指令 

查看密碼訊息

chage -l   

參數: 

-m PASS_MIN_DAYS 

-M PASS_MAX_DAYS 

-W PASS_WARN_AGE 

-E 帳號到期日 

-d 設定密碼變更時間,設定為0代表下次登入需更改密碼