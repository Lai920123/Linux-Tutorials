# 安裝VMware workstation

## 安裝步驟 ##

## Debian ##
先到官往下載安裝檔   
[Download VMware Workstation Pro](https://www.vmware.com/products/workstation-pro/workstation-pro-evaluation.html)
    
![Untitled](Install_VMWare_Workstation_On_Linux/Untitled.png)
    
### 安裝GCC
    
```bash
sudo apt -y install gcc build-essential 
```
    
### 執行安裝檔
    
```bash
#進入剛剛下載安裝檔的路徑
cd ~/Download 
#給予執行權限
chmod +x ./VMware-Workstation-Full-16.2.4-20089737.x86_64.bundle
#執行安裝檔
./VMware-Workstation-Full-16.2.4-20089737.x86_64.bundle
```
## Fedora ##
同樣先到官往下載安裝檔   
[Download VMware Workstation Pro](https://www.vmware.com/products/workstation-pro/workstation-pro-evaluation.html)

```bash
dnf install kernel-headers kernel kernel-devel gcc make #安裝核心,gcc,make 
dnf groupinstall "Development tools" #安裝部屬工具
dnf update #更新套件庫
reboot #重新啟動
./VMware-Workstation-Full-16.2.4-20089737.x86_64.bundle #執行下載的檔案
git clone https://github.com/mkubecek/vmware-host-modules #手動安裝模組
cd vmware-host-modules
git checkout workstation-16.2.3
sudo make ; sudo make install
```
## 將OVA轉換為OVF ##

```bash
ovftool test.ova test.ovf
```
## 解除安裝 ##
```bash
sudo vwmare-installer -u vmware-workstation
```

## VMware Tools ##

點選Install VMware Tools

![Untitled](VMWare%20Tools%20db927dd08e2e42a0bc7df9d517bc4ff6/Untitled.png)

```python
#進入掛載光碟的目錄
cd /media/cdrom0
#複製檔案至/tmp
cp VMwareTools-10.3.23-16594550.tar.gz /tmp
#進入/tmp
cd /tmp
#解壓縮
tar zxpf VMwareTools-10.3.23-16594550.tar.gz
#進入壓縮後的目錄
cd vmware-tools-distrib
#執行安裝檔
./vmware-install.pl
#安裝完成
```

新版的輸入以下指令即可

```bash
sudo apt update #更新套件源
sudo apt-get install open-vm-tools #安裝open-vm-tools
```
