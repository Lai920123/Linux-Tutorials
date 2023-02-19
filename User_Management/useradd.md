# useradd #

## 參數 ##
```
useradd 
    -m 建立家目錄 
    -u 設定UID 
    -s 設定shell 
    -g 設定主要群組 
    -G 設定次要群組 骨架目錄 也就是家目錄的預設範本,位於/etc/skel 當創建使用者時,會複製此檔案內容至使用者家目錄
```

## 變更密碼 ##

```bash
passwd  user 
#也可以直接以資料流導入
echo “P@ssw0rd” | passwd –stdin user001 
#若上面那種不行,可以試試看下面這個 
echo “user:P@ssw0rd” | chpasswd
```

## 大量新增使用者&設定預設密碼 ## 

在一個公司裡總是會有許多使用者的問題,創建時不可能一個一個創,所以就需要批次建立的方法 假設要建立IT01~50 

```bash
#! /bin/bash
for i in {1..100}
do 
    adduser --disabled-password --gecos "" user$i #--disabled-password為跳過詢問密碼，--gecos為跳過填寫基本信息(姓名,電話等...)
    echo "user$i:P@ssw0rd" | chpasswd 
    chage -d 0 user$i #下次登入修改密碼
done 
```

## 完整刪除使用者和使用者家目錄 ##

```bash
#! /bin/bash 
for i in {1..100}
do 
    userdel --remove user$i
done 
```

/sbin/nologin:只不允許系統login，其他服務還是可以登入

/bin/false:所以服務都無法使用