# modprobe

Linux使用modprobe安裝驅動，modprobe可以檢查套件的相依性並安裝

## 產生模組依賴性檔案

```bash
#modprobe需依賴modules.dep知道模組間的相依性，depmod用來產生此檔案
#路徑位於/lib/modules/5.10.0-15-amd64/modules.dep
depmod
```

## 新增模組

```bash
modprobe <module>
```

## 刪除模組

```bash
rmmod <module>
```

## 檢視模組資訊

```bash
lsmod 
modinfo <module>
```