# GRE over IPSec

![Untitled](GRE%20over%20IPSec%206f7d48a98555451baee177c35e1536cb/Untitled.png)

- 建立GRE Tunnel
    
    HQ和BRANCH都已做好NAT
    
    ### HQ
    
    ```bash
    #使用vim編輯
    vim /etc/network/interface
    #編輯以下內容
    auto gre1
    iface gre1 inet static
    address 10.0.0.1 #tunnel使用的IP位置
    netmask 255.255.255.0
    pre-up ip tunnel add gre1 mode gre remote 123.0.2.2 local 123.0.1.2
    post-down ip tunnel del gre1
    up ip route add 192.168.1.0/24 via 10.0.0.2 dev gre1 
    ```
    
    ### BRANCH
    
    ```bash
    #使用vim編輯
    vim /etc/network/interface
    #編輯以下內容
    auto gre1
    iface gre1 inet static
    address 10.0.0.2 #tunnel使用的IP位置
    netmask 255.255.255.0
    pre-up ip tunnel add gre1 mode gre remote 123.0.2.2 local 123.0.1.2
    post-down ip tunnel del gre1
    up ip route add 172.16.1.0/24 via 10.0.0.1 dev gre1 #新增靜態路由
    ```
    
- IPSec
    
    以下使用兩種不同的套件分別進行操作，可依照使用方式選擇適合的套件
    
    - 使用libreswan
        
        ### 安裝套件
        
        ```python
        apt -y install libreswan
        ```
        
        ### HQ
        
        ### 金鑰管理
        
        ```python
        #初始化
        ipsec initnss
        #生成金鑰
        ipsec newhostkey 
        #列出keyid
        ipsec showhostkey --list
        #查看金鑰
        ipsec showhostkey --left --ckaid 7e8848c6354e0c7437ea5d763d22e1383a0e8969
        ```
        
        ### 編輯設定檔
        
        ```python
        #使用vim編輯，最好先複製一份，避免設定錯誤無法返回
        vim /etc/ipsec.conf
        #編輯以下內容
        config setup 
            protostack=netkey
        conn gre1 
            left=123.0.1.2
            right=123.0.2.2
            authby=rsasig
            auto=start
            leftprotoport=gre
            rightprotoport=gre
            phase2=esp #使用esp封裝(預設)
            type=transport #封裝模式
            leftrsasigkey= #HQ生成的金鑰
            rightrsasigkey= #等等BRANCH生成的金鑰，可透過SCP傳送過來之後再使用資料流導入進設定檔
        ```
        
        ### BRANCH
        
        ```bash
        #初始化
        ipsec initnss
        #生成金鑰
        ipsec newhostkey 
        #列出keyid
        ipsec showhostkey --list
        #查看金鑰
        ipsec showhostkey --left --ckaid 09ef8ca00cf968d50877b9d880356863fdd89291
        ```
        
        ### 編輯設定檔
        
        ```python
        config setup 
            protostack=netkey
        conn gre1 
            left=123.0.2.2
            right=123.0.1.2
            authby=rsasig
            auto=start
            leftprotoport=gre
            rightprotoport=gre
            phase2=esp #使用esp封裝(預設)
            type=transport #封裝模式
            leftrsasigkey= #BRANCH生成的金鑰
            rightrsasigkey= #HQ生成的金鑰，可透過SCP傳送過來之後再使用資料流導入進設定檔
        ```
        
        ### 重啟服務
        
        ```python
        systemctl restart ipsec
        ```
        
    - 使用strongswan
        
        ### 安裝套件
        
        ```bash
        apt -y install strongswan-swanctl
        apt -y install charon-systemd
        ```
        
        ### HQ
        
        ```bash
        #使用vim編輯
        vim /etc/swanctl/conf.d/swanctl.conf
        #編輯以下內容 
        connections {
            vpn1 {
                version = 2
                local_addrs = 123.0.1.2
                remote_addr = 123.0.2.2
                proposals = aes128-sha1-modp2048,default
                aggressive = yes
                dpd_delay = 5s
                dpd_timeout = 15s
                local {
                    auth = psk
                    id = 123.0.1.2
                }
                remote {
                    auth = psk 
                    id = 123.0.2.2
                }
                children {
                    vpn1 {
                        esp_proposals = aes128-sha1-modp2048,default
                        local_ts = 192.168.1.0/24
                        remote_ts = 172.16.1.0/24
                        mode = tunnel
                        dpd_action = restart 
                        start_action = trap 
                    }
                }
            }
        }
        secrets {
            ike-vpn1 {
                secret = "P@ssw0rd"
                id = 123.0.2.2
            }
        }
        ```
        
        ### BRANCH
        
        ```bash
        #使用vim編輯
        vim /etc/swanctl/conf.d/swanctl.conf
        #編輯以下內容 
        connections {
            vpn1 {
                version = 2
                local_addrs = 123.0.2.2
                remote_addr = 123.0.1.2
                proposals = aes128-sha1-modp2048,default
                aggressive = yes
                dpd_delay = 5s
                dpd_timeout = 15s
                local {
                    auth = psk
                    id = 123.0.2.2
                }
                remote {
                    auth = psk 
                    id = 123.0.1.2
                }
                children {
                    vpn1 {
                        esp_proposals = aes128-sha1-modp2048,default
                        local_ts = 172.16.1.0/24
                        remote_ts = 192.168.1.0/24
                        mode = tunnel
                        dpd_action = restart 
                        start_action = trap 
                    }
                }
            }
        }
        secrets {
            ike-vpn1 {
                secret = "P@ssw0rd"
                id = 123.0.1.2
            }
        }
        ```