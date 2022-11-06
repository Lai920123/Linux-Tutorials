# target #

Target可以用來指定開機時要使用的模式，例如命令行或者圖形化

## 常見的target ##

```bash
    graphical.target 多人模式,圖形化 
    multi-user.target 多人模式,文字介面 
    reboot.target 重新開機,重新開機是會在開機時不斷重新開機,所以通常用不太到 
    halt.target 關機,關機是會在開機時不斷關機,所以通常用不太到
```

## 指令 ##

```bash
#查看目前使用target
systemctl get-default 
#查看所有target
systemctl list-unit-files –type=target  
#更改default target，此指令會將/etc/systemd/system/default.target建立一個軟連接到/lib/systemd/system/內指定的target內
systemctl set-default graphical.target 代表預設開機為多人圖形化模式 systemctl set-default multi-user.target 代表預設開機為多人文字介面模式
```
  
若在更改時不小心造成系統無法進入圖形化介面或者文字介面，該如何處理，首先進入系統grub boot loader選單時，案任意建取消倒數


接著按下'e'進入編輯



找到開頭為linux那行，並在最後方加入想要的target，如若是要進入多人文字介面，則在最後方輸入systemd.unit=multi-user.target接著按下Ctrl + x以此設定重新開機就完成了



進入系統後記得將default.target改回去，否則下次開機又會無法進入