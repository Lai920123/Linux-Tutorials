;
; BIND data file for domain.com
;

$TTL 604800 
@     IN  SOA     ns1.domain.com. root.domain.com. (
                            2        ; Serial 
                       604800        ; Refresh 
                        86400        ; Retry 
                      2419200        ; Expire 
                       604800 )      ; Negeative Cache TTL 
;
      IN  NS      ns1.domain.com.
ns1   IN  A       127.0.0.1
ns1   IN  AAAA    ::1 
www  IN  A       172.18.0.2
