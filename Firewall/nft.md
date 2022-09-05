# nft

nft沒有像iptables一樣有預設的表格，需自己建立表格並寫入規則鏈及規

則nft是由{}一層一層包裹起來，最外層為Table，再來是Chain、rule,以下會依序建立Table，chain和rule，最後在用範例介紹filter，nat，route的方法

## 參數

```bash
-h 列印基本幫忙
-v 查看版本
-n 不使用名稱解析
```

## Family

```bash
ip(default)
ipv6
inet
arp
bridge
```

## Table

### 新增表格

```bash
nft add table <family> <table name>
nft add table ip test
```

### 刪除表格

```bash
nft delete table <family> <table name>
nft delete table ip test
```

### 查詢表格

```bash
nft list tables (查詢所有表格(若是有寫iptables也會顯示在這裡))
nft list table <family> <table name> (指定表格)
```

## Chain

### 新建Chain

```bash
nft add chain <family> <table name> <chain name> { type <filter/nat/route>  <hook> <posrouting/prerouting/input/forward/output> <priority> <number> \;> }
nft add chain ip test input { type filter hook input priority 0 \; }
```

### 刪除Chain

```bash
nft delete chain <family> <table name> <chain name>
nft delete chain ip test input
```

## Rule

### 新建rule

```bash
#這裡先不寫,後面filter,nat,route的部份會在講
nft add rule <table name> <chain name> 
```

### 刪除rule

```bash
nft delete rule <table name> <chain name> <handle> <number>
```

## Hook

Hook在建立鏈時由type指定

### Type

```bash
postrouting #改變來源
prerouting #改變目的
input #進來的封包
forward #封包轉發
output #傳出去的封包
```

## Filter

nft有10種過濾方式

```bash
accept
continue
drop
goto
jump
limit
log
queue
reject
return
```

這裡使用常用的三種accept,reject,drop

```bash
#先建立一個表格(可以自行取名)
nft add table <family> <table name>
nft add table ip filter
#加入兩條filter規則鏈一條叫input，一條叫output(可以自行取名)
nft add chain <family> <table name> <chain name> <type filter hook <input/output/forward> <priority> <number> \; >
nft add chain ip filter input { type filter  hook input priority 0 \; }
nft add chain ip filter output { type filter hook output priority 0\; }
#使用nft list table filter可以看到
table ip filter {
chain input {
    type filter hook input priority filter; policy accept;
}
#過濾服務
#接受服務
nft add rule ip filter input tcp dport 22 accept
nft add rule ip filter input tcp dport 80 accept
#拒絕服務
nft add rule ip filter input tcp dport 22 reject
nft add rule ip filter input tcp dport 80 reject
#直接丟棄
nft add rule ip filter input tcp dport 22 drop
nft add rule ip filter input tcp dport 80 drop
```

## NAT

```bash

#先建立table(可以自行取名)
nft add table ip nat
#加入一條Chain叫做nat(可自行取名)
nft add chain <family> <table name> <chain name> { type nat hook <postrouting/prerouting> <priority> <number> \; }
nft add chain ip nat postrouting { type nat hook postrouting priority 0 \; }
#加入一條規則
nft add rule <family> <table name> <chain name> <postrouting/prerouting> ip <source address> <network segment/host> oif(output interface) <nicname> <sourca nat> to <ip address>
nft add rule ip nat postrouting ip saddr 192.168.1.0/24 oif ens33 snat to 123.0.1.1
#最後使用nft list table nat查看表格會出現
table ip nat {
    chain nat {
        type nat hook postrouting priority filter; policy accept;
        ip saddr 192.168.1.0/24 oif "ens33" snat to 123.0.1.1
    }
}
```

## Port Forwarding

```bash
#建立一個表格(可以自行取名)
nft add table <family> <table name>
nft add table ip nat
#加入一條Chain叫做port_forwarding
nft add chain <family> <table name> <chain name> { type nat hook <postrouting/prerouting> <priority> <number> \; }
nft add chain ip nat port_forwarding { type nat hook prerouting priority -100 \; }
#加入一條規則
nft add rule <family> <table name> <chain name> iif(input interface) <interface name> <protocol> <destination port> {80,443} <destination nat> to <host>
nft add rule ip nat port_forwarding iif ens33 tcp dport { 22,80 } dnat to 192.168.1.2
```

## route

## 全部拒絕