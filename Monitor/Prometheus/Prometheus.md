# Prometheus #

## 安裝Prometheus ##

```bash

```

## 開機自動啟動Prometheus ##

```bash
[Unit]
Description=Prometheus 
Wants=network-online.target
After=network-online.target
[Service]
User=Prome
Group=Prome
Type=Simple
ExecStart=/usr/local/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/var/lib/prometheus/ --web.console.templates=/etc/prometheus/consoles --web.console.libraries=/etc/prometheus/console_libraries
[Install]
WantedBy=multi-user.target
```

```bash
systemctl daemon-reload 
systemctl enable --now prometheus.service 
```

## Reference ## 

https://0xzx.com/zh-tw/2021071700421597804.html