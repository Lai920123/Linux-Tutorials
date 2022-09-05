# find-file

locate

從已建立好的資料庫中尋找,但有時會因資料庫未更新而找不到檔案,可以使用updatedb更新資料庫 

資料庫路徑 

kali:/var/lib/plocate/plocate.db 

centos:/var/lib/mlocate/mlocate.db 

 -i 忽略大小寫差異

whereis

針對特定目錄下的binary,source,help文件進行搜尋 

-l 查看whereis會尋找的目錄 

-b 只尋找binary格式的檔案 

-s 只尋找source檔案

find
find是Linux中非常好用的查詢工具,可以用來查詢檔案或目錄位置,但 跟locate和whereis相比速度會較慢 

-name 搜尋檔名 

-iname 忽略大小寫並搜尋檔名 

-type 搜尋檔案類型 -empty 空檔案 

-perm 搜尋特定權限 

-exec 執行命令 

-user 指定使用者的檔案 

執行命令,範例將所有權限777的檔案cp至/tmp/find 

```
find / -type f -perm 777 -exec cp -a {} /tmp/find  \;  
```

{}指的是前面找到的輸出,結尾要加上\;