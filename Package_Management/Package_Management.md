# 套件管理 #

>Linux的每個發行版都有自己的套件管理工具，以下會盡量詳細的寫出管理套件源,安裝套件,移除套件,故障排除等管理套件的方式，避免大家在安裝套件時不斷跳錯卻不知如何解決

## Debian ## 
    
>Debian提供了HTTP,FTP和CD-ROM/DVD來訪問套件源，也可使用PPA加入個人套件源，且擁有多種套件管理工具，下面將一一列出使用方法與範例

## 加入HTTP,FTP套件源 ##

    若是使用HTTP或FTP的套件源，需要進入設定檔進行修改，設定檔路徑位於/etc/apt/sources.list以及/etc/apt/sources.list.d/底下，/etc/apt/sources.list.d/底下可創建多個

    Debian官方建議的注意事項
    /etc/apt/sources.list中不要包含testing或unstable 
    不要在設定檔中寫入非Debian的套件源，如Ubuntu
    不要建立/etc/apt/preferences
    不要使用dpkg -i <*.deb>安裝套件
    不要使用dpkg --force-all -i <*.deb>安裝套件
    不要刪除或修改/var/lib/dpkg中的文件
    不要讓使用原始碼安裝的套件覆蓋系統文件，若是需要，可安裝於/usr/local/和/opt中



## 新增CD-ROM和第三方套件源方式 ##

>在Linux中絕大部分的套件都來自於官方套件庫，但若是需要的套件不存在於官方套件庫，就需要使用到個人套件庫
```bash
#新增CD-ROM/DVD套件源
apt-cdrom add /media/cdrom0 #/media/cdrom0為掛載好的DVD
#新增個人件源
add-apt-repository ppa:<套件庫名稱>
#記得以上加入套件源後都必須更新套件源後才可使用
apt update  
```

## 移除第三方套件源 ##

```bash

```

## 更新套件源與套件 ##

```bash
apt update #更新套件來源而已，並不會更新套件
apt upgrade #更新套件

```

## 安裝套件 ##

>Debian可以使用apt或者dpkg來安裝套件，下面兩種安裝方法差異在於apt會安裝相依性套件，而dpkg只會安裝本地的.deb軟體包，不會解決相依性問題，deb檔案有時會提供ppa資訊，安裝.deb時也會連同裡面的PPA資訊以及GPG Key一同安裝

```bash
apt update #安裝軟體前可以先更新套件源，以確保安裝的版本為較新的
apt install vim #安裝vim，連同相依性套件一同安裝
apt install ./code_1.72.2-1665614327_amd64.deb #安裝.deb軟體包
dpkg -i code_1.72.2-1665614327_amd64.deb #不會安裝相依性套件
```

## 移除套件 ##

```bash
apt remove vim #刪除套件但不刪除相依性套件以及設定檔
apt remove --purge vim #刪除套件和配置檔案
apt autoremove --purge vim #autoremove會刪除無用的套件，--purge將刪除設定檔，不過此指令須小心使用，可能不小心將系統重要套件給刪除
```

## 清除安裝檔 ##

>使用apt安裝的deb套件，會存放於/var/cache/apt/archives/，不會自動刪除，可使用以下指令刪除

```bash
apt clean #全部清除
apt autoclean #清除過期的DEB軟體包
```

## RedHat ##

## 參考文章 ##

https://www.debian.org/doc/manuals/debian-reference/ch02.zh-cn.html#_debian_package_management_prerequisites

https://www.arthurtoday.com/2010/02/apt-dpkg.html
