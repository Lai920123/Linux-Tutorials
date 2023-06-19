
# logging # 

```bash
logging {
    channel default_log {
        file "/var/log/named/default.log";
        print-time yes;
        print-category yes;
        print-severity yes;
        severity dynamic; 
    };
    channel general_log {
        file "/var/log/named/general.log";
        print-time yes;
        print-category yes;
        print-severity yes;
        severity dynamic;
    };
    channel notify_log {
        file "/var/log/named/notify.log";
        print-time yes;
        print-category yes;
        print-severity yes;
        severity dynamic;
    };
    channel network_log {
        file "/var/log/named/network.log";
        print-time yes;
        print-category yes;
        print-severity yes;
        severiry dynamic;
    };
    channel queries_log {
        file "/var/log/named/queries.log";
        print-time yes;
        print-category yes;
        print-severity yes;
        severiry dynamic;

    };
    channel query-errors_log {
        file "/var/log/named/query-errors.log"; 
        print-time yes;
        print-category yes;
        print-severity yes;
        severiry dynamic;

    };
    channel lame-servers_log {
        file "/var/log/named/lame-servers.log"
        print-time yes;
        print-category yes;
        print-severity yes;
        severiry dynamic;
    };
    category default { default_log; };
    category general { general_log; };
    category notify { notify_log; };
    category network { network_log; };
    category queries { queries_log; };
    category queries-errors { query-errors_log; };
    category lame-servers { lame-servers_log; };
};
```