# Quota

Quota預設是針對整個分割區進行限制，可以用來對使用者或群組的使用空間進行限制

## Quota限制

```bash
#soft
最低限制容量，使用者在寬限時間內容量可以超過soft，但必須在寬限時間內將磁碟容量降到soft限制之下
#hard
不能超過的容量，當快超過時，會警告使用者，讓使用者在寬限期間內，將容量降低至soft limit內
#寬限時間
空間超過soft但還沒到達hard limit前，就會請使用者將磁碟容量降至soft limit下，在使用者降低後，寬限時間就會取消
```

## 查看Quota

```bash
參數
-u 顯示user
-g 顯示group
-v 顯示quota詳細訊息
-s 以人類好閱讀方式顯示
#查看目前使用者
quota -guvs
#查看指定使用者
quota -uvs Test
```

## 編輯Quota

```bash
#欄位介紹
filesystem 分割區
blocks     目前使用者使用空間，不需變更
soft       最低限制容量，0為無限制，單位為Kbytes
hard       不能超過容量，0為無限制，單位為Kbytes
inodes     目前使用掉inode狀態，不需變更
soft 
hard

#編輯使用者Quota
edquota -u user001
#編輯群組Quota
edquota -g user001
#複製Quota資料，複製user001的Quota資料至user002
edquota -p user001 -u user002
#設定寬限時間
edquota -t 

```