# firewall-cmd

Firewall-cmd的出現替代了舊有的iptables,使用區域的方式管理規則,並使用動態方式執行,修改後立即生效 並且兩者只能夠則一使用,否則可能會出現問題

安裝firewalld dnf -y install firewalld

啟動服務 systemctl enable firewalld #開機時啟動 systemctl start firewalld

各個區域描述 drop 丟棄所有封包,只允許往外 block 拒絕外部所有連線,並會收到icmp-host-prohibited訊息回復 public 公開區域,預設為不允許任何連線,只有允許的連線才放行 dmz 非軍事區域,允許對外連線,內部只有允許的規則才可連線 work 工作環境,信賴同區域網內的連線,外部需要建立允許規則才可連線 home 家庭環境,信賴同區域網內的連線,外部需要建立允許規則才可連線 external 外部區域,適用於NAT對外限制 internal 內部區域,應用於NAT對內限制 trusted 接受所有連線

參數 –state 顯示防火牆狀態 –reload 防火牆重啟

開啟port firewall-cmd –zone=public –permanent –add-port=8080/tcp