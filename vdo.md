# vdo

Virtual Data Optimizer虛擬資料優化 

## 安裝vdo

若依照rhcsa講義安裝的話repositroy的centos8要更改為8.2才不會因為/boot空間不夠而無法

```bash
yum -y install vdo
```

## 建立vdo

```bash
vdo create –name=vdo1 –device=/dev/sda –vdoLogicalSize=50G
```

 

## 查看vdo

```bash
vdo list
```

## 啟用vdo

```bash
systemctl enable vdo 
systemctl start vdo
```

## 開機自動掛載

```bash
#格式化
mkfs -t xfs /dev/mapper/vdo1 
#編輯
vim /etc/fstab
/dev/mapper/vdo1 /share xfs default 0 0 
#掛載fstab寫入的內容
mount -a 

```

## 刪除vdo

```bash
vdo remove -n vdo1
```