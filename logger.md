# logger

logger指令用來操作syslog的系統日誌

## 參數

```bash
-d 使用UDP
-i 紀錄每一個log的pid
-f 紀錄特定文件
-n 指定log server
-P 使用指定的port
-p 指定優先級
-s 輸出標準錯誤至系統日誌
```

## 寫入文字至Syslog

```bash
logger "Hello"
#查看log
cat /var/log/messages
```

## 指定Log Server

```bash
#指定log server為10.1.1.100，並更改Port號為8888
logger -n 10.1.1.100 -P 8888
```