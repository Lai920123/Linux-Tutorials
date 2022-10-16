# ProxyChain #

>再與目標連線前，可設定多個代理，來達到匿名效果

## 安裝套件 ##

```bash
sudo add-apt-repository ppa:webupd8team/tor-browser
sudo apt update
sudo apt -y install tor-browser
sudo apt -y install proxychains4
```

## 編輯設定檔 ##

```bash
#使用vim編輯
sudo vim /etc/proxychains.conf
#取消註解
dynamic_chain
#加入以下幾行
socks5 127.0.0.1 9050
```

## 啟用Tor ##

```bash
systemctl start tor 
```

## 使用方法 ##

```bash
proxychains4 firefox 
proxychains4 firefox www.google.com
```