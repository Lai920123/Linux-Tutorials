# Network

在Linux中,有非常多種網路設定方式，以下會列出最常用到的幾種，可以自行依照實做時遇到的來配置

## 使用ip配置

使用IP配置並不是永久的，下次開機時會消失

### 新增IP

```python
ip addr add 192.168.1.100/24 dev ens33
#新增完之後需要開啟
ip link set dev tunnel0 up
```

### 刪除IP

```python
ip addr del 192.168.1.100/24 dev ens33
```

### 建立tunnel

```python
ip tunnel add tunnel0 mode gre remote 123.0.1.2 local 123.0.1.1 ttl 255
```

### 新增預設閘道

```python
ip route add default via 192.168.1.254 dev ens33
```

### 刪除預設閘道

```python
ip route del default via 192.168.1.254 dev ens33
```

## Debian

### 查看網卡名稱

```bash
ip address
```

### 編輯設定檔

```bash
#使用vim編輯
vim /etc/network/interfaces 
#輸入以下內容，ens33更改自己裝置中的網卡名稱
auto ens33 #開機自動掛載
iface ens33 inet static (iface=interface,inet=ipv4(如果是ipv6就使用inet6),static=靜態配置IP,動態的話輸入DHCP) 
address 192.168.1.100 #IP位置 
netmask 255.255.255.0 #遮罩 
gateway 192.168.1.254 #預設閘道
#一張網卡多個IP，例如要新增192.168.1.101-102到ens33
auto ens33:0
iface ens33:0 inet static
address 192.168.1.101
netmask 255.255.255.0
gateway 192.168.1.254
auto ens33:1
iface ens33:1 inet static
address 192.168.1.102
netmask 255.255.255.0
gateway 192.168.1.254
#建立GRE Tunnel
auto gre1
iface gre1 inet static
address 192.168.1.2 #tunnel使用的IP位置
netmask 255.255.255.0
pre-up ip tunnel add gre1 mode gre remote 123.0.1.1 local 123.0.1.2
post-down ip tunnel del gre1
#新增靜態路由，up代表設備開啟時啟用
up ip route add 10.0.2.0/24 via 192.168.1.1 via dev gre1 
#新增預設路由，up代表設備開啟時啟用
up ip route add 0.0.0.0/0 via 192.168.1.1 via dev ens33
#配置完成後，重新啟動機器就可以了
```

## Ubuntu

使用netplan來配置，netplan是使用yaml的語法來做編輯，所以要特別注意空格，若是格式錯了就會無法正確啟動，設定檔位於/etc/netplan底下，若是沒有可以自行創建一個像是01-netcfg.yaml 

### 編輯設定檔

```yaml
#使用vim編輯
vim /etc/netplan/01-netcfg.yaml 
#加入以下內容
network: 
  version: 2 
  renderer: networkd #使用networkd這個deamon 
  ethernets:       
    ens33: 
  addresses: [ 192.168.1.100/24 ] #IP位置和遮罩 
  gateway4: 192.168.1.254 
  nameservers: 
  search: [ www.lai.com ] 
  addresses: [ 8.8.8.8 168.95.1.1 ]
```

### 檢查配置

```bash
netplan try
```

### 套用配置

```bash
netplan apply 
```
### NetworkManager ###

若是覺得netplan不太好用，也可使用NetworkManager來對網路進行配置，如果沒有NetworkManager須先安裝

### 安裝套件 ###

```bash
sudo apt -y install network-manager
```

### 替換為NetworkManager ###
```bash
#要使用NetworkManager，須先進行以下設定
#使用vim編輯
sudo vim /etc/netplan/test.yaml #test.yaml為原本網路的設定檔，請依照實際檔名進行更改
#開啟之後將內容全部刪除，並套用
netplan apply 
#新增設定檔於NetworkManager
sudo touch /etc/NetworkManager/conf.d/01-network-manager-all.conf
#重新載入服務
systemctl reload NetworkManager`
#接著就可以使用NetworkManager進行配置了
nmcli connection #查看網卡
nmcli connection modify ens33 ipv4.addresses 192.168.1.100/24 ipv4.gateway 192.168.1.1 ipv4.dns 8.8.8.8 ipv4.method manual 
```

### 管理vmnet ###

```bash
#使用nmcli查看vmnet，可以看到顯示unmanaged 
nmcli
#開啟介面管理
nmcli dev set vmnet2 managed yes
#配置IP
nmcli connection modify vmnet2 ipv4.addresses 192.168.1.100/24 ipv4.gateway 192.168.1.254 ipv4.dns 8.8.8.8 ipv4.method manual

```

## CentOS

CentOS有多種方式可以進行網路的配置

### 使用nmcli來配置網路

也可以使用nmtui進行圖形化的設定

### 查看網卡名稱

```bash
#以下兩種都可
nmcli device
#可以看到UUID和連線類型
nmcli connection 
```

### 配置方式

```bash
nmcli connection modify ens33 \
ipv4.addresses 192.168.1.100/24 \ #IP位置和遮罩 
ipv4.gateway 192.168.1.254 \ #預設閘道 
ipv4.dns 8.8.8.8 \ #DNS
ipv4.method manual #配置方法為手動，DHCP的話輸入auto
```

### 新增第二個IP

```bash
nmcli connection modify ens33 +ipv4.addresses 192.168.1.101/24
```

### 刪除第二個IP

```bash
nmcli connection modify ens33 -ipv4.addresses 192.168.1.101/24
```

### 查看配置

```bash
nmcli connection show ens33
```

### 啟動網卡

```bash
nmcli connection up ens33
```

### 停用網卡

```bash
nmcli device disconnect ens33
```

## 使用設定檔配置網路

### 編輯設定檔

```bash
#使用vim編輯
vim /etc/sysconfig/network-script/ifcfg-<網卡名稱>
#依照實際情況更改以下內容
TYPE=Ethernet 
PROXY_METHOD=none 
BROWSER_ONLY=no 
BOOTPROTO=static #dhcp(自動配置),static(手動配置) DEFROUTE=yes 
IPV4_FAILURE_FATAL=no 
IPV6INIT=yes 
IPV6_AUTOCONF=yes 
IPV6_DEFROUTE=yes 
IPV6_FAILURE_FATAL=no 
IPV6_ADDR_GEN_MODE=stable-privacy 
NAME=enp0s3
UUID=fc289d60-31ad-4d3c-a668-14d7445efa41 
DEVICE=enp0s3
ONBOOT=yes #開機時啟動此網路介面 
IPADDR=192.168.1.100 #IP位置 
GATEWAY=192.168.1.1 #預設閘道 
NETWORK=192.168.1.0 #網段 
NETMASK=255.255.255.0 #子網路遮罩 
DNS1=168.95.1.1 #DNS Server 
DNS2=8.8.8.8 #DNS Server
```

### 重啟NetworkManager

```bash
systemctl restart NetworkManager
```

## DNS設定

Linux各個發行版中,設定DNS的方式都是位於/etc/resolv.conf這個設定檔 

### 編輯設定檔

```bash
#使用vim編輯
vim /etc/resolv.conf 
#加入DNS就完成了
nameserver 8.8.8.8 
```

## 名稱解析

名稱解析的設定檔位於etc/hosts

### 編輯設定檔

```bash
#使用vim編輯
vim /etc/hosts 
#寫入對應的名稱跟IP就完成了 
192.168.1.100 ns1.lai.com 
192.168.1.101 www.lai.com
```