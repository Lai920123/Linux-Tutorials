# tuned

tuned能夠根據系統使用情況信息,動態調整Linux的設定 安裝tuned dnf -y install tuned

啟動tuned systemctl enable tuned systemctl start tuned

查看目前系統使用的profile tuned-adm active

列出可用的profile tuned-adm list

查看系統推薦的profile tuned-adm recommend

更改profile tuned-adm profile