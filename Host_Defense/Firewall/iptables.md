# iptables

## 參數

```bash
-t 後面接上Table(nat),預設為filter
-A 新增一條規則在原本規則的後面 
-I 插入一條規則,如果未指定此規則的順序,預設為第一條,比如說原本有1-4四條規則,插入後就會變成2-5,插入的這條規則變第一條 
-i 進入的介面,eth0,eth1…,需與INPUT配合 
-o 出去的界面,eth0,eth1…,需與OUTPUT配合 
-L 列出目前Table的規則 
-n 不做名稱解析,顯示速度較快 
-v 列出更多資訊 
-s 來源IP(192.168.1.1)或網段(192.168.1.0/24) 
-d 目標IP(192.168.1.1)或網段(192.168.1.0/24) 
-p 設定此規則適用哪些封包格式,主要有tcp,udp,icmp,all 
-P 定義政策(Policy)[INPUT,OUTPUT,FORWARD],[ACCEPT,DROP] 
-j 後面接動作,主要有ACCEPT,REJECT,DROP,LOG,要打大寫 
–dport 限制目標Port,可以連續如1:65535,只有tcp,udp具有Port,所以需連同-p [tcp]一起使用 
–sport 限制來源Port,可以連續如1:65535,只有tcp,udp具有Port,所以需連同-p [tcp]一起使用 
-m iptables的外掛模組，常見的有: state:狀態模組 mac:Mac地址 
--state 封包的狀態，主要有
        INVALID:無效的封包 
        ESTABLISHED:已經連線成功的連線狀態 
        NEW:想要建立新連線的封包狀態 
        RELATED:表示封包與主機自己送出的封包有關
```

## Table

### filter(預設)

有INPUT、OUTPUT和FORWARD三個Chain

### nat

用於進行來源或目的地位置的轉換，有下列型式

- POSTROUTING - 來源位置的轉換
- MASQUERADE - 來源NAT的特殊形式，用來做IP偽裝，也就是SNAT
- PREROUTING - 目的地位置的轉換
- REDIRECT - 目的地NAT的特殊形式，重新導向封包至本地主機，而不是使用IP表頭的目的地位置，例如Port Forwarding

### mangle

暫時不會

## Policy

```bash
ACCEPT
REJECT
DROP
```

## 印出iptables規則

```bash
#印出預設規則 
iptables -L
#印出詳細規則
iptables -nvL
#印出nat規則
iptables -t nat -L
#印出mangle規則
iptables -t mangle -L
#除了以上方法還可以使用以下指令查看
iptables -S
iptables-save 
iptables-save -t nat
```

## 清除iptables規則

```bash
#清除預設filter規則
iptables -F 
#清除nat的規則
iptables -t nat -F  
#清除mangle的規則
iptables -t mangle -F 
#列出rule id
iptables -L INPUT -n --line-numbers
iptables -L -t nat -n --line-numbers
#刪除特定ID的rule 
iptables -D INPUT 1
iptables -D -t nat PREROUTING 1
```

## 允許服務進入

```bash
iptables -A INPUT -p tcp –-dport 22 -j ACCEPT #ssh 
iptables -A INPUT -p tcp –-dport 23 -j ACCEPT #telnet 
iptables -A INPUT -p tcp –-dport 53 -j ACCEPT #用在dns zone transfer,若只是要查詢不需要tcp 53 port 
iptables -A INPUT -p udp –-dport 53 -j ACCEPT #DNS查詢 其他的就依照開啟的服務帶入以上就可以了
```

## 允許來源進入

```bash
iptables -A INPUT -i ens33 -s 192.168.1.10 -j ACCEPT 
iptables -A INPUT -i ens33 -s 192.168.1.0/24 -j ACCEPT
```

## NAT

### 開啟封包繞送

```bash
#找到net.ipv4.ip_forward=1並取消註解
vim /etc/sysctl.conf 
```

### 使變更立即生效

```bash
sysctl -p
```

### 來源偽裝

```bash
iptables -t nat -A POSTROUTING -o ens33 -j MASQUERADE
```

### Port Forward

```
iptables -t nat -A PREROUTING -i ens33 -p tcp –-dport 22 -j DNAT –-to-destination 192.168.1.1:22
```

### 特殊用法

在本機進行port轉換,用戶端使用22 Port但進到本機後會導向8888 Port

```
iptables -t nat -A PREROUTING -p tcp –-dport 22 -j REDIRECT --to-ports 8888
```

## 禁止icmp

```
iptables -A INPUT -i ens33 -p icmp -j DROP
```

## 如果關聯本機的封包則可以通過

檢測是否為主機發出去請求的回應，因為連線是雙向的，例如今天要查看外部的網站，Request出去了,但最後的規則寫了這條iptables -P INPUT DROP，就會導致封包回不來，不然就是要另外寫很多條紀錄，開啟此規則後，若是關聯發出去的封包，則開放進入

```
iptable -A INPUT -m state –state RELATED,ESTABLISHED -j ACCEPT
```

## 針對MAC進行管制

較少用到

```
iptables -A INPUT -m mac –mac-source aa:bb:cc:dd:ee:ff -j ACCEPT iptables -A INPUT -m mac –mac-source aa:bb:cc:dd:ee:ff -p tcp –dport 22 -j ACCEPT
```

## 除以上規則以外全部拒絕

```
#以下規則使用iptables -L查看不到，須使用iptables -S
iptables -P INPUT DROP 
iptables -P OUTPUT DROP 
iptables -P FORWARD DROP
```

## iptables開機自動啟動

### 第一種方式

```bash
#將以下規則寫在此檔案裡，重開機時需執行su -才會啟動
cd /root 
vim .bashrc 
```

### 第二種方式

寫完所有規則後，將資料備份到/etc/iptables.up.rules 

```bash
iptables-save > /etc/iptables.up.rules 
```

由備份設定還原 

```bash
iptables-restore < /etc/iptables.up.rules 
```

寫一個shell script讓開機時自動讀取 

```bash
#使用bash編輯
vim /etc/network/if-pre-up.d/iptables 
#!/bin/sh 
/sbin/iptables-restore < /etc/iptables.up.rules
<ESC>:wq存檔 
```

接著給予執行權限就完成了 

```
chmod +x /etc/network/if-pre-up.d/iptables
```

### 第三種方式

```bash
#安裝套件，安裝時會跳出是否儲存，選擇是即可
sudo apt -y install iptables-persistent
#若是安裝完之後需要重新儲存請輸入以下指令
sudo dpkg-reconfigure iptables-persistent
```