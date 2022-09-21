# chattr

Chattr指令用來設定檔案的各種屬性，防止檔案的誤刪，使用chattr進行設定後，即使有管理員權限也無法修改檔案

## 參數

```bash
-R 遞迴
```

## 屬性

```bash
a 只能以附加方式寫入
A 不更新檔案存取時間
c 先將檔案內容壓縮後，在寫入硬碟，讀取時也會進行解壓縮
C 關閉copy-on-write
d 使用dump時，排除此類檔案
i 不可變動檔案
s 安全刪除檔案，確保檔案確實刪除
S 檔案內容變更時，同步寫入硬碟
```

## 查看檔案屬性

```bash
lsattr 
lsattr sshd_config 
```

使用lsattr查詢/etc/ssh/底下所有檔案屬性結果，也可指定檔案查詢

![Untitled](chattr%207765074aa7e1491a8685f22eea906b79/Untitled.png)

## 新增屬性

```bash
#使用+,-來新增或移除屬性
#讓test.txt無法被刪除
chattr +i test.txt 
#移除屬性
chattr -i test.txt
```