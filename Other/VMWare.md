# VMWare Tools

點選Install VMware Tools

![Untitled](VMWare%20Tools%20db927dd08e2e42a0bc7df9d517bc4ff6/Untitled.png)

```python
#進入掛載光碟的目錄
cd /media/cdrom0
#複製檔案至/tmp
cp VMwareTools-10.3.23-16594550.tar.gz /tmp
#進入/tmp
cd /tmp
#解壓縮
tar zxpf VMwareTools-10.3.23-16594550.tar.gz
#進入壓縮後的目錄
cd vmware-tools-distrib
#執行安裝檔
./vmware-install.pl
```

安裝完成