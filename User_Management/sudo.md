# sudo

## 編輯設定檔

設定檔位於/etc/suoders，注意不要使用一般文字編輯器編輯此檔案，可能導致文件損壞，或拒絕管理員訪問，使用visudo編輯，也可將單獨檔案寫至/etc/sudoers.d，例如echo "user1 (ALL=ALL) NOPASSWD:ALL >> /etc/sudoeers.d/user1

```bash
#預設的別名，裡面包含了可使用的一些指令，可以使用別名給予sudo使用者使用指令的權限，也可以自訂別名
Host Aliases
User Aliases
Networking
Installation and management of software
Services
Updating the locate database
Storage,Delegating permissions
Processes,Drivers
```

## sudo timout時間

一般來說，輸入密碼進入sudo後，會有幾分鐘的時間可以不在輸入密碼就可使用sudo權限，在設定檔中也可以設定sudo timeout時間，更改以下這行，代表每次輸入完密碼後，下次使用sudo都必須再次輸入密碼，若設定為-1則代表永遠不用輸入密碼，也可以在下面設定NOPASSWD

```bash
default timestamp_timeout=0
```

## 限定哪些使用者可使用sudo

有幾種方式

### 變更設定檔

```bash
#格式為
User_List Host_List = [(User_List)] [NOPASSWD: | PASSWD:] Cmd_List
#欄位解說
User_List:此規則設定於哪個用戶，%group代表群組
Host_List:應用於已知的主機列表，可填入主機名或IP，ALL代表全部
(User_List):告訴sudo用戶名字串可以替代哪個用戶，多個使用者使用","間隔
[NOPASSWD: | PASSWD:]:代表使用sudo不用輸入密碼，預設為PASSWD，設定為NOPASSWD:ALL代表所有指令都不須輸入密碼
Cmd_List:使用者可以使用哪些指令
```

### 加入群組

預設wheel群組的成員都可使用root身份執行所有sudo指令

## 特殊用法

sudo通常用來讓使用者替換為root進行工作，但也可以拿來作為變更使用者執行或創建檔案，例如目前使用者為user，要變更成為test並創建資料夾名為test，可以這樣打

```bash
sudo -u test mkdir test
```

