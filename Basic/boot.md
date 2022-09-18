# boot擴充辦法

卸載/boot 

```
umount /boot
```

建立一資料夾 

```
mkdir /boot_old 
```

將舊的分割區掛載到/boot_old中

```
mount /dev/sda1 /boot_old 
```

使用fdisk分割一個新分割區並掛載到/boot

將/boot_old/下的檔案複製到/boot/中 

```
 cp -a /boot_old/* /boot/ 
```

使用fdisk的a參數修改開機引導區