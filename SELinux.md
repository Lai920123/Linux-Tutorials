# SELinux

設定檔位於/etc/selinux底下 

## SELinux有三種模式

```bash
Enforcing #強制模式,依據設定限制檔案存取 
Permissive #寬容模式，不限制檔案存取，但會依據設定檢查並記錄訊息 
Disabled #關閉SELinux
```

## 切換SELinux模式

```bash
#臨時切換模式,關機就消失，此方法無法設定為disabled
setenforce [ Enforcing or 1 | Permissive or 0 ] 
#或者是直接修改設定檔 
vim /etc/selinux/config 
將SELINUX=[enforcing | permissive | disabled ]
```

## 查看目前所在哪種模式

```bash
#只顯示Enforcing,Permissive或Disabled
getenforce 
#顯示較詳細訊息
sestatus 
```

## 查詢SELinux contexts

```bash

#查看每個檔案的SELinux contexts
ls -Z 
#查看每個程序的SELinux contexts
ps -auxZ 
#可以看到有四個欄位 
identify:role:type:level
#例如 
-rw-r–r–. 1 root root system_u:object_r:httpd_sys_content_t:s0 10 Dec 25 2020 file1 
```

```bash
#程序:
     identify:
          root:表示身分為root
          system_u:表示為系統程序
          unconfined_u:表示為使用者自行開啟,如vim
     role:
          system_r:代表程序
          unconfined_u:為使用者自行開啟,如vim
     type:
          此類型通常最為重要,在程序裡稱為domain
     level:
          targeted:CentOS預設
          mls:較為嚴格
#檔案:
     identify:
          system_u:表示為系統程序,可控管
          unconfined_u:表示為使用者自行開啟,如vim,無法控管
     role:
          object_r:代表檔案或目錄等
     type:
          此類型通常最為重要,在檔案裡稱為type
          user_home_t:使用者家目錄
          admin_home_t:管理員家目錄
     level:
          targeted:CentOS預設
          mls:較為嚴格
```

## 修改檔案檔案或目錄的SELinux context

使用cp指令時若是沒有加參數-a，會繼承目的地的SELinux

```bash
chcon -<param> <filename>
參數
	-R 連同目錄下檔案一同更改
	-u <user>
	-r <role> 
	-t <type>
	--reference=範例檔案
```

## 將檔案恢復成SELinux contexts的預設值

設定檔位於/etc/slinux/targeted/contexts內，裡面紀錄了預設的SELinux context類型

```bash
restorecon <filename>
參數
	-R 連同目錄下檔案一同更改
	-v 將過程顯示到螢幕上
```

## 查詢SELinux contexts預設規則與狀態

### 安裝工具

```bash
dnf -y install policycoreutils-python-utils
```

```bash
semanage {login|user|port|interface|fcontext|translation}
參數
     -l 查詢
     -a 增加
     -m 修改
     -d 刪除
     -p port
     -D 刪除所有自定的context
		 -t type
     login: 
     user:
     port:
          查詢port的資訊
          semanage port -l | egrep http
          為Port相關的context新增額外的port號
          semanage port -a -t http_port_t -p tcp 8080
     interface:
     fcontext:
          用於SELinux contexts,因為訊息量很大,建議用grep過濾訊息
          查詢檔案的預設contexts,而不是指/etc/passwd此目錄的contexts
          semanage fcontext -l | egrep /etc/passwd
          指定檔案的預設contexts
          semanage fcontext -a -t <type> "<path>(/.*)?"
     translation:
```

## 查詢程序對檔案讀寫權限的context type

### 安裝工具

```bash
dnf -y install setools-console
```

```bash
sesearch 
參數
     -A 搜尋所有allow的規則
     -s 指定搜尋來源
     -c 指定規則作用對象,如file或者process
     -p 選擇作用於對象的行為,如read和write
範例
sesearch -A -s http_t -c file -p read -p write
```

## 查詢SELinux布林值規則的狀態

```bash
getsebool -a | grep <service name>
範例
	getsebool -a | grep ssh
	ssh_chroot_rw_homedirs --> off
	ssh_keysign --> off
	ssh_sysadm login --> off
	ssh_use_tcpd --> off
```

## SELinux政策的布林值

```bash
查詢
seinfo 
CentOS預設政策為Target
     Types:target的政策有4934個(值不一定一樣)
     Booleans:網路服務有327條規則(值不一定一樣)
參數
     -b 列出所有規則的種類
     -a 列出SELinux的狀態
     -u 列出user種類
     -r 列出role種類
     -t 列出type種類
```

## 關閉SELinux布林值規則

```bash
setsebool 
範例
setsebool ssh_sysadm login on
```

log檔位於/var/log/audit/audit.log