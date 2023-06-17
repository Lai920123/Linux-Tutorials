# Trouble Shooting #

dumping master file: /etc/bind/tmp-nIOVHD85JX: open: permission denied

此錯誤代表已成功進行zone transfer，但無法寫入區域文件，因沒有目錄的權限，解決辦法為以下

```bash
#因安全問題，在Debian建議將named.conf.local的file路徑更改為/var/lib/bind
zone "example.com" {
    type slave;
    file "/var/lib/bind/db.example.com";
    masters {
        192.168.1.100;
    };
};

zone "1.168.192.in-addr.arpa" {
    type slave;
    file "/var/lib/bind/db.1.168.192";
    masters {
        192.168.1.100;
    };
};
```

## Reference ##

http://www.microhowto.info/howto/configure_bind_as_a_slave_dns_server.html#idm42