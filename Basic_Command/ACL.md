# ACL

ACL提供Linux在傳統權限之外能夠針對使用者或群組進行更細部的設定 

## 查看檔案或目錄的acl

```
getfacl
```

## 更改檔案或目錄的acl

```
setfacl
參數
	-m 設定acl參數給檔案或目錄使用
	-x 刪除檔案或目錄的acl參數
	-b 移除所有acl設定參數 
	-k 移除預設acl參數 
	-R 遞迴設定acl,連子目錄一同設定 
	-d 設定預設acl參數,只對目錄有效
```

## 設定檔案或目錄的acl

```
setfacl -m u::rwx #使用者權限 g::rwx #群組權限 o:rwx #其他人權限 m:rwx #mask
```

## 刪除指定檔案或目錄的acl

```
setfacl -x user /tmp/test
```

## 刪除所有acl設定參數

```
setfacl -b user /tmp/test
```