# Zone Transfer #

## 配置方法 ##
    
## Master ##

```bash
#使用vim編輯
vim /etc/bind/named.conf.local
#加入以下內容
zone "example.com" {
    type master;
    file "/etc/bind/example.com";
    notify yes;
    allow-transfer { #預防CVE-1999-0532，只zone transfer給授權的DNS Server，也可以放在naemd.conf.option 
        192.168.1.2;
    };
};
zone "1.168.192.in-addr.arpa" {
    type master;
    file "/etc/bind/1.168.192.rev";
    notify yes;
    allow-transfer { #預防CVE-1999-0532，只zone transfer給授權的DNS Server，也可以放在named.conf.option
        192.168.1.2;
    };
};
```

## Slave ##
    
```python
#使用vim編輯
vim /etc/bind/named.conf.local
#加入以下內容
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
#因效能考量，Slave的Zone file會以binary的方式儲存，所以打開會是亂碼，若要變更為文字格式，請在/etc/bind/named.conf.options的options內加入以下這行
masterfile-format text;
```