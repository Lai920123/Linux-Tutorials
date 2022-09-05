# Bind9

## 安裝Bind9

```bash
apt -y install bind9 dnsutils #dnsutils不一定要安裝，測試用
```

## DNS Server Type

- 介紹
    
    ### hint
    
    根伺服器，根伺服器的Zone file會預設放在/usr/share/dns/root.hints
    
    ### Master
    
    主要伺服器，在bind8中已經由Master取代Primary
    
    ### Slave
    
    次要伺服器，與Master定期進行zone transfer傳送區域資訊，避免主要伺服器故障，bind8中已經由Slave取代Secondary 
    
    ### Stub
    
    只會複製Master的NS紀錄，而非所有區域資訊
    
    ### Forward
    
    委派，可將請求轉送給其他伺服器處理
    

## 設定檔

- 設定檔解說
    
    ### /etc/bind/named.conf.local
    
    此設定檔用於定義正解及反解的zone
    
    ```python
    #使用vim編輯
    vim /etc/bind/named.conf.local
    #寫入以下內容
    #域名正解
    zone "it29.local" {
        type master; #主要區域
        file "/etc/bind/db.local";  
    };
    #域名反解
    zone "1.1.192.in-addr.arpa" {
        type master;
        file "/etc/bind/db.1.168.192"
    };
    ```
    
    ### /etc/bind/named.conf.options
    
    此設定檔可以定義log以及ACL等參數
    
    ```python
    #acl，指定可以存取的IP，internal是自己取的名稱
    acl internal {
        10.0.0.0/8;
        172.16.0.0/16;
        192.168.0.0/16;
    };
    #control
    controls {
        inet 127.0.0.1 allow { localhost; } keys { rndckey; };
    };
    #options
    options {
    #相對路徑zone file擺放位置
        directory "/var/"; 
    #允許查詢的IP
        allow-query {
            internal;
        }
    #允許Zone Transfer的IP
        allow-transfer { 
            192.168.1.2;
        };
    #監聽IPv4位置
        listen-on { 
            192.168.1.1 };
    #監聽IPv6位置
        listen-on-v6 { any; };
    recursion {
            
        };
    };
    #logging
    logging {
        channel it29.local {
            buffered yes #是否刷新錯誤日誌文件
            file "/var/log/named/example.log" versions 3 size 250k suffix timestamp; #log檔案路徑、版本、大小、格式
            serverity info; #日誌等級
        };
        category default {
            it29.local;
        };
    };
    
    ```
    
    ### named.conf.default-zones
    
    此設定檔記錄了root Server、localhost的zone
    
    ## Zone file
    
    設定檔：/etc/bind/db.local，假設要加入以下Resource Record，www.it29.local做load balance
    
    | ns1 | 192.168.1.1 |
    | --- | --- |
    | ns2 | 192.168.1.2 |
    | www | 192.168.1.1 |
    |  | 192.168.1.2 |
    | mail  | 192.168.1.2 |
    
    ### 正向對應區域
    
    ```python
    #複製一份設定檔作為範本(要直接編輯也可)，以區域名稱作為檔名，比較好記憶
    cp /etc/bind/db.local /etc/bind/db.it29.local
    #使用vim編輯
    vim /etc/bind/db.it29.local
    #寫入以下內容
    ;
    ; BIND data file for example.com
    ;
    $TTL 604800 #最小存留時間(秒)
                      #主要伺服器      #負責人
    @    IN    SOA    ns1.it29.local. root.it29.local. (
                            2         ; Serial #版本，當zone file變動時管理員要自行增加號碼，slave會進行比對和決定是否要進行zone transfer
                       604800         ; Refresh #重整間隔(秒)，Slave詢問Primary更新區域的重整間隔
                        86400         ; Retry  #重試間隔(秒)，每隔多少秒再試一次
                      2419200         ; Expire #到期時間(秒)，直到到期，Slave的區域會停止回答
                       604800 )       ; Negative Cache TTL #這個紀錄的存留時間(秒)
    ;
          86400   IN    NS    ns1.example.com.
    ns1   86400   IN    A     192.168.1.1
    ns2   86400   IN    A     192.168.1.2
    www   0       IN    A     192.168.1.1
          0       IN    A     192.168.1.2
          86400   IN    MX 10 mail.lai.com
    mail  86400   IN    A     192.168.1.2
    ```
    
    ### 反向對應區域
    
    ```python
    ;
    ; BIND reverse data file for example.com 
    ;
    $TTL    604800
    @    IN    SOA    ns1.example.com. root.example.com. (
                                     1      ; Serial 
                                604800      ; Refresh 
                                 86400      ; Retry 
                               2419200      ; Expire 
                                604800 )    ; Nagative Cache TTL
    ;
          IN   NS    ns1.example.com.
    1     IN   PTR   ns1.example.com.
    2     IN   PTR   ns2.example.com.
    
    ```
    

## Zone Transfer

- 使用方法
    
    ### Master
    
    ```python
    #使用vim編輯
    vim /etc/bind/named.conf
    #加入以下內容
    include "/etc/bind/named.conf.default-zones";
    include "/etc/bind/named.conf.local";
    include "/etc/bind/named.conf.options";
    zone "example.com" {
        type master;
        file "/etc/bind/example.com";
        notify yes;
        allow-transfer {
            192.168.1.2;
        };
    };
    zone "1.168.192.in-addr.arpa" {
        type master;
        file "/etc/bind/1.168.192.rev";
        notify yes;
        allow-transfer {
            192.168.1.2;
        };
    };
    ```
    
    ### Slave
    
    ```python
    #使用vim編輯
    vim /etc/bind/named.conf
    #加入以下內容
    include "/etc/bind/named.conf.default-zones";
    include "/etc/bind/named.conf.local";
    include "/etc/bind/named.conf.options";
    zone "example.com" {
        type slave;
        file "slave/example.com.saved";
        masters {
            192.168.1.1;
        };
    };
    zone "1.168.192.rev" {
        type slave;
        file "slave/1.168.192.rev.saved";
        masters {
            192.168.1.1;
        };
    };
    #因效能考量，Slave的Zone file會以binary的方式儲存，所以打開會是亂碼，若要變更為文字格式
    #請在/etc/bind/named.conf.options的options內加入以下這行
    masterfile-format text;
    ```
    

## rndc

- 使用方法
    
    rndc是一個管理bind的工具，對DNS Server進行關閉、重載、清除快取、增加以及刪除Zone等操作，還可以再不關閉DNS Server的情況下更新變更後的數據，使用TCP 953
    
    ### 查看狀態
    
    ```python
    rndc status
    ```
    
    ### 重載配置文件與Zone file
    
    ```python
    rndc reload 
    ```
    
    ### 重載指定區域
    
    ```python
    rndc reload it29.local
    ```
    
    ### rndc配置文件
    
    路徑：/etc/bind/rndc.key
    
    ```python
    #產生rndc.key
    rndc-confgen -a
    #產生rndc.conf
    rndc-confgen >> rndc.conf
    #編輯named.conf
    key "rndc-key" {
        algorithm hmac-sha256;
        secret "Te6Ym2whgjcA+n49A4UoTTCAnvKDZ/z9+MoYboiK/RI=";
    };
    controls {
        inet 127.0.0.1 port 953
            allow { 127.0.0.1; } keys { "rndc-key"; };
    };
    
    ```