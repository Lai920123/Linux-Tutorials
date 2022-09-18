# 安裝圖形化界面

## GNOME

### 安裝套件

```python
apt -y install gnome
```

### 更改target

```python
systemctl set-default graphical.target
```

## KDE

### 安裝套件

```powershell
apt -y install task-kde-desktop
```

跳出配置時選擇sddm，然後更改target之後重啟即可

## Xfce

### 安裝套件

```powershell
apt -y install task-xfce-desktop
```

跳出配置時選擇lightdm，然後更改target之後重啟即可