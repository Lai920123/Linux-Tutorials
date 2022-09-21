# date #

### 查詢時間

```
date
```

### 自訂輸出格式

```bash
#以下列出幾個常用的
%Y 年 
%m 月
%d 日
%H 小時，24小時制
%I 小時，12小時制
#指令格式
date +%Y-%m-%d
#輸出結果
```

![Untitled](Time%20ae636f0341e84859aa136bc35c1f847e/Untitled.png)

### 更改時間

```bash
#有多種不同格式，使用自己好記的就好
date -s "20220624 12:00:00"
date -s "2022/06/24 12:00:00"
date -s "2022-06-24 12:00:00"
```

## RTC

Real-time clock 實時時鐘，也可稱做硬體時鐘

### 查看時間

```bash
hwclock
```

### 將系統時鐘寫入硬體時鐘

```bash
hwclock -w 
```

## Systemd

### 查看時間

```bash
timedatectl
```

### 設定時間

```bash
timedatectl set-time "2022-06-24 12:00:00"
```

### 設定time-zone

```bash
#使用grep過濾出想要設定的時區
timedatectl list-timezones | grep Asia
#設定時區，假設要設定為Asia/Taipei
timedatectl set-timezone "Asia/Taipei"
```

### NTP自動校時

```bash
#開啟
timedatectl set-ntp yes
#關閉
timedatectl set-ntp no
```