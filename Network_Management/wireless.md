# Wireless #

## 查看無線網卡 ##

```bash
iwconfig
```

## 搜尋無線基地台 ##

```bash
iwlist <網卡名稱> scan | grep ESSID
```

## 連結基地台 ##

```bash
iwconfig <網卡名稱> essid <'ssid'> key s:'P@ssw0rd'
```

## 取得DHCP分配的IP ##

```bash
dhclient eth0
```
