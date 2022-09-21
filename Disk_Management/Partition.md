# Partition

## 查看硬碟分割狀況

```bash
df -h 
fdisk -l 
lsblk
```

假設要分割的硬碟為/dev/sdb 

在進行所有磁碟分割時,最好先將已掛載的分割區umount 

## MBR分割

### 選擇分割硬碟

```bash
fdisk /dev/sdb  
```

進入分割模式後可以看到 

```bash
#可以輸入m獲得幫助,若沒有問題輸入n開始進行分割 
Command(m for help):
#詢問分割類型(詳細類型可以Google MBR) 
Partition type 
p primary #主要分割區 
e extended #延伸分割區
Select (default p):p #建立主要分割區 
#磁碟編號預設為1,若不用更改就直接Enter 
Partition number (1-4, defulat 1): 
#磁區開始位置,預設不用更改 
First sector (2048-41943049, default 2048): 
#假設要分割5G,就輸入+5G,以此類推 
Last sector, +/-sectors or +/-size{K,M,G,T,P} (2048-41943039, default 41943039):
#上面動作都完成後會回來此畫面,輸入w儲存檔案 這樣就分割完成了
Command (m for help): w 
```

## GPT分割方式

GPT使用parted這個工具來分割 

### 安裝方式

```bash
#debian
sudo apt -y install parted 
#CentOs
sudo dnf -y install parted
```

### 分割磁碟

```bash
#指定磁碟，若這裡沒指定也可以在後面指定
parted /dev/sdb 
#這裡要選擇正確的磁碟 
GNU Parted 3.4 Using /dev/sdb
#提示你可以輸入help查看幫助畫面 
Welcome to GNU Parted! Type ‘help’ to view a list of commands. 
#若是在一開始進入時沒選擇磁碟,也可以輸入此指令選擇 
(parted) select /dev/sdb 
#一開始要先建立一個磁碟分割表(lable有幾種類型bsd,loop,gpt,mac,msdos,pc98,sun,MBR的硬碟可以使用msdos,GPT使用gpt)
(parted) mklable gpt  
#建立主要分割區
(parted) mkpart  
#分割區名稱
Partition name? [] ? 1  
#檔案系統類型 
File System type? [ext2] ? ext4 
#開始位置 
Start? 1 
#結束位置 
End? 100-0 
#分割完成後可以使用print再次確認配置
```

### 更改容量:

可以使用resizepart修改容量,但有可能會造成資料流失 

```bash
(parted) resizepart 
#分割區名稱
Partition number? 1 
#結束位置
End? [10.0GB] ? 10240 
Warning: Shrinking a partition can cause data loss, are you sure you want to continue? Yes/No? y 
#完成修改
(parted)
```

### 刪除磁碟

```bash
#查看分割表
(parted) print 
#刪除分割number 2  
(parted) rm 2 
#完成刪除
(parted)
```

### 修復分割區

使用rescue修復分割區,用法是指定開始和結尾來進行搜尋錯誤,若有發現錯誤,就會嘗試救援 

```bash
(parted) rescue 
#開始位置
Start? 1
#結束位置 
End? 1999
#搜索完成,若出現警告請注意警告內容並選擇Yes/No 
(parted) 
```

## 格式化

分割完成後,需要將硬碟格式化

```bash
mkfs.ext4 /dev/sdb1
#或者是
mkfs -t ext4 /dev/sdb1
```

## 掛載

格式化後,需要將硬碟掛載,使用mount這個指令 假設要將/dev/sdb1 掛載到/home/user/以下的話 

```bash
mount /dev/sdb1 /home/user/ 
```

就可以將硬碟掛載到/home/user/內了

## 開機時自動掛載

## /etc/fstab設定檔各欄位介紹

```bash
[device]      可寫UUID或者是分割區位置
[mount point] 要掛載的位置 
[filesystem]  檔案系統類型 
[parameters]  
async 會先暫存於記憶體中 sync 會將資料寫入硬碟 
auto 開機時是否自動掛載 noauto 開機時不會自動掛載 
rw 可讀可寫 ro 唯獨 
exec 可執行 noexec 不可執行 
user 使用者可以使用mount指令掛載 nouser 使用者不可使用mount指令掛載 
suid 檔案允許SUID nosuid 檔案不允許SUID 
usrquota 支援使用者配額模式 grpquota 支援群組配額模式 
defaults 代表使用rw,suid,exec,auto,nouser,async等功能 iocharset=設定編碼 
[dump] 是否能使用dump指令備份,0:不能 1:要備份,較重要 2:要備份,較不重要 
[fsck] 開機時以fsck檢驗磁區,0:不檢驗 1:先檢驗 2:後檢驗
```

### 查詢UUID

```bash
#查詢UUID，因為/etc/fstab指定磁碟的方式可以使用UUID,UUID是linux裝置的唯一識別碼,就不會 有像是Windows指定磁碟代號,若是重新開機後代號跑掉,造成找不到硬碟的問題 
blkid 
#範例輸出
/dev/mapper/cs-swap: UUID=“cf44302d-863e-45ee-9fae-6d1944b2b3cc” TYPE=“swap” 
/dev/sdb1: PARTUUID=“d938fc02-01” 
/dev/sr0: BLOCK_SIZE=“2048” UUID=“2022-04-29-21-32-45-00” LABEL=“CDROM” TYPE=“iso9660” 
/dev/mapper/cs-root: UUID=“aea1d97a-b24f-43d4-8959-c61bfe17b5d8” BLOCK_SIZE=“512” TYPE=“xfs” 
/dev/sda2: UUID=“ShJFLt-xIdK-Pi52-9l5u-Cstq-S820-972qFu” TYPE=“LVM2_member” PARTUUID=“4ba68041-02” 
/dev/sda1: UUID=“469a7503-99fe-4486-911d-3d12a2e066f0” BLOCK_SIZE=“512” TYPE=“xfs” PARTUUID=“4ba68041-01” 
/dev/sr1: BLOCK_SIZE=“2048” UUID=“2022-04-19-14-46-46-00” LABEL=“CentOS-Stream-9-BaseOS-x86_64” TYPE=“iso9660” PTUUID=“540c43d3” PTTYPE=“dos”
#或使用ls查詢
ls -lh /dev/disk/by-uuid
```

### 編輯設定檔

```bash
vim /etc/fstab 
```

掛載硬碟的寫法為 [device] [mount point] [filesystem] [parameters] [dump] [fsck]

```bash

UUID=469a7503-99fe-4486-911d-3d12a2e066f0 /home/user ext4 defaults 0 0 
#或者是 
/dev/sda1 /home/user ext4 default 0 0
```

### 測試掛載

```bash
#掛載fstab寫入的內容
 mount -a 
```

## swap

### 查看swap

```bash
swapon -s
free -h
```

### 配置swap

先分割出swap的大小,假設使用/dev/sdb並有20GB,並分割出一個2GB作為swap

```bash
fdisk /dev/sdb 
n 
p 
+2G 
t 
82 
w
```

### 初始化swap

```bash
mkswap /dev/sdb1
```

### 開啟swap(立即生效)

```bash
swapon /dev/sdb1
```

### 關閉swap

```bash
swapoff /dev/sdb1
```

### 開啟swap(開機自動掛載)

```bash
#編輯設定檔
vim /etc/fstab 
#更改以下內容
/dev/sdb1 none swap defaults 0 0
```

## TroubleShooting ##
### Windows 10 / Windows Server 2012 後 因Windows快速開機功能導致Linux掛載硬碟Cache卡住無法寫入 ###
錯誤輸出：

    Failed to mount '/dev/sdb2': Operation not permitted
    The NTFS partition is in an unsafe state. Please resume and shutdown
    Windows fully (no hibernation or fast restarting), or mount the volume
    read-only with the 'ro' mount option.

解決辦法：
    
    因預設掛載硬碟使用rw，只能先掛載為ro
    1.安裝套件 
    sudo apt -y install ntfs-3g
    2.掛載成ro
    sudo mount -t ntfs-3g /dev/sda1 /media/test -ro force
    3.修復Cache部份
    ntfsfix /dev/sda1
    4.重新掛載成為rw，但因此方法掛載狀態較不穩定，所以不建議寫入fstab中
    sudo mount -w -t ntfs-3g /dev/sda1 /media/test