# DHCP

## 安裝套件

```bash
apt -y install isc-dhcp-server
```

## 設定檔參數(挑要用的)

設定檔路徑：/etc/dhcp/dhcpd.conf

```bash
#使用vim編輯
vim /etc/dhcp/dhcpd.conf
#編輯以下內容
authoritative; #說明此DHCP Server為官方伺服器
default-lease-time 3600; #預設有效的租約時間(秒)，可以是全域變數也可以單獨定義於子網段
max-lease-time 86400; #最大租約時間(秒)，可以是全域變數也可以單獨定義於子網段

#建立pool
subnet 192.168.1.0 netmask 255.255.255.0 {
    range 192.168.1.100 192.168.1.199; #發放範圍
    option routers 192.168.1.254; #預設閘道
    option subnet-mask 255.255.255.0; #子網路遮罩，可以省略
    option broadcast-address 192.168.1.255; #可以省略
    option domain-name "lai.com" #域名
    option domain-name-servers 8.8.8.8; #DNS Server
    default-lease-time 3600; #預設有效的租約時間(秒)，可以是全域變數也可以單獨定義於子網段
    max-lease-time 86400; #最大租約時間(秒)，可以是全域變數也可以單獨定義於子網段
}
#保留區，可用來設定PXE主機
host PC1 {
    hardware ethernet 11:22:33:44:55:66;
    fixed-address 192.168.1.150;
    option host-name PC1; #可以省略
}
#group可以組合共用pool，讓多個pool使用相同參數
group {
    option domain-name "lai.com";
    option domain-name-servers 8.8.8.8;
    subnet 

```

## Failover

一般伺服器架構中，不會只有一台DHCP Server，因為只有一台的話，若是故障了，整間辦公室甚至整間公司的電腦將會收不到IP，導致無法上網，所以通常會設置2台以上的DHCP Server做failover(容錯移轉)

### Primary

```bash
#使用vim編輯
vim /etc/dhcp/dhcpd.conf
#編輯以下內容
failover peer "failover-partner" {
    primary;
    address 192.168.1.100; #Primary IP Address
    port 647; #Primary Port 
    peer address 192.168.1.101; #Secondary IP Address
    peer port 647; #Secondary Port 
    max-response-delay 60;
    max-unacked-update 10;
<< comment
Maximun Client Lead Time(只在primary定義)，主節點恢復後收到對等
方租約數據庫後須等待的時間，等待完成後主節點才能開始處理DHCP封包，設
定越短，轉移時間越快，但負載較高，設定越長，轉移越慢，但負載較低
comment
    mclt 3600; 
<< comment
定義兩台伺服器之間的負載(只在primary定義)，為0~256的值，128代表兩
台伺服器進行50/50負載平衡，256代表沒有負載平衡
comment
    split 128; 
    load balance max seconds 3;
}
#聲明至子網段
subnet 192.168.1.0 netmask 255.255.255.0 {
    option routers 192.168.1.254; #預設閘道
    option domain-name "lai.com" #域名
    option domain-name-servers 8.8.8.8; #DNS Server
    default-lease-time 3600; #預設有效的租約時間(秒)
    max-lease-time 86400; #最大租約時間(秒)
    pool {
        failover peer "failover-partner"; #剛剛上面定義的
        range 192.168.1.100 192.168.1.199; #發放範圍        
}
```

### Secondary

```bash
#使用vim編輯
vim /etc/dhcp/dhcpd.conf
#編輯以下內容
failover peer "failover-partnet" {
    secondary;
    address 192.168.1.101; #Secondary IP Address
    port 647; #Secondary Port 
    peer address 192.168.1.100; #Primary IP Address
    peer port 647; #Primary port 
    max-response-delay 60;
    max-unacked-updates 10;
    load balance max seconds 3;
}
#聲明至子網段
subnet 192.168.1.0 netmask 255.255.255.0 {
    option routers 192.168.1.254; #預設閘道
    option domain-name "lai.com" #域名
    option domain-name-servers 8.8.8.8; #DNS Server
    default-lease-time 3600; #預設有效的租約時間(秒)
    max-lease-time 86400; #最大租約時間(秒)
    pool {
        failover peer "failover-partner"; #剛剛上面定義的
        range 192.168.1.100 192.168.1.199; #發放範圍        
}
```

## DHCP Relay Agent

### 安裝套件

```bash
apt -y install isc-dhcp-relay 
```

### 編輯設定檔

```bash
#使用vim編輯
vim /etc/default/isc-dhcp-relay
#編輯以下內容
SERVERS="192.168.1.100"
INTERFACES="ens34 ens36" #一張為連接伺服器，一張為Relay Agent分配網段的那張網卡
OPTIONS=""
```

### 重啟服務

```bash
systemctl restart isc-dhcp-relay 
```

## DHCP Snooping

```bash

```

## 管理服務

### 開啟服務

```bash
systemctl start isc-dhcp-server
```

### 關閉服務

```bash
systemctl stop isc-dhcp-server
```

### 重啟服務

```bash
systemctl restart isc-dhcp-server
```

### 查看服務狀態

```bash
systemctl status isc-dhcp-server
```