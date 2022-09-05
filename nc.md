# nc

netcat是一款非常強大的網路工具 

安裝netcat 

```
yum -y install nc
```

測試port是否開啟 

```
nc -v 192.168.1.110 80
```

傳送UDP封包到遠端伺服器 

```
echo -n “Test” | nc -u -wl 192.168.1.111 5000
```