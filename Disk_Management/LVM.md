# LVM

PV(Physical volume) 實體卷 VG(Volume group) 卷組 PE(Physical extend) 實體延伸區 LV(Logical volume) 邏輯卷

多個PV組成VG,而VG可以分為數個LV

新增分割區 

```
fdisk /dev/sdb 
```

將System ID改成8e 

要先將分割區變為PV,才能供LVM使用,一個實體分割區對應一個PV 建立PV pvcreate /dev/sdb1 若是有多個可以這樣寫 pvcreate /dev/sdb{1..5} 查看PV 

```
pvs 
pvscan 
pvdisplay(詳細)
```

將PV還原成實體分割區 

```
pvremove
```

VG由一到多個PV所組成。建立VG之後，我們還可以任意增加PV到VG，或從VG減少PV PE最多只能有65535個,所以可以依照設定的PE大小算出總容量 

建立VG 

```
vgcreate -s <PE大小,預設為4MB>   
vgcreate -s 32M vg1 /dev/sdb1 
vgcreate -s 32M vg1 /dev/sdb{1..3}
```

查看VG 

```
vgs 
vgscan 
vgdisplay
```

刪除VG

需先將LV卸載和SWAP關閉,刪除時會詢問是否要刪除LV再一併刪除就好 

```
vgremove vg1
```

新增PV到VG 

```
vgextend vg1 /dev/sdb4
```

從VG移除PV 

```
vgreduce vg1 /dev/sdb1
```

啟用和關閉VG,啟動VG,會將VG中的所有LV啟動,停用VG,會將VG中的所有LV停用 

啟用

```
vgchange -a y vg1 
```

關閉 

```
vgchange -a n vg1
```

VG改名

```
vgrename vg1 vg10
```

LV相當於虛擬分割區，由一到多個PE所組成。建立LV之後，我們可以任意增加PE到 LV，或減少PE，使LV彈性調整容量。一個VG可以包含多個LV，就像一個實體磁碟 可以建立多個分割區一樣，可以使用lvs查詢lv的UUID進行掛載

建立lv 

```
lvcreate -l <PE數量> -n <LV名稱> <VG名稱>
lvcreate -L 容量 -n <LV名稱> <VG名稱>
```

以上兩種方式都可以

刪除lv,使用fdisk -l找到裝置名稱 

```
lvremove /dev/mapper/vg1-pub
```

查看LV 

```
lvs
lvscan 
lvdisplay
```

調整LV大小 

```
lvresize -l <PE數量> <LV名稱>
lvresize -l +<PE數量> <LV名稱>
lvresize -L <容量> <LV名稱>
lvresize -l +20 /dev/vg1/pub
```

啟用和關閉LV,LV啟用時,才能建立檔案系統或掛載 

啟用 

```
lvchange -a y /dev/vg1/pub 
```

關閉

```
lvchange -a n /dev/vg1/pub
```

修改LV名稱 

```
lvrename vg1 pub pubx
```

搬移使用中的PE到未使用的PE,目的地需有足夠的未使用PE數,主要用於在要刪除PV的環境下 ,若內部的PE還在使用,直接移除的話可能會造成資料毀損,所以需要先將PE移動到未使用的PE 中再進行移除

```
pvmove <來源> <目的地> 
pvmove /dev/sda1 /dev/sda3 #單一目的地 
pvmove /dev/sda1 /dev/sda2 /dev/sda3 #多個目的地 
pvmove /dev/sda1 #未指定目的地,會將PE搬移到VG未使用的PE中
```

調整檔案系統大小 若要將檔案系統變大,不需要卸載,可以直接調整 放大縮小 

```
lvextend -l +20 /dev/vg1/pub resize2fs /dev/vg1/pub
```

先卸載 

```
umount /share resize2fs -f /dev/vg1/pub 512M (512M必須寫在後面) 
lvresize -L 512M /dev/vg1/pub
```

不管放大縮小,都直接更改,-r:連同resize2fs一併執行，若是沒有使用resize2fs就只會擴充lv，檔案系統容量不會變更

```
lvresize -L 2048M -r /dev/vg1/pub 
lvresize -L 32M -r /dev/vg1/pub
```

SWAP LV使用與放大縮小 操作方法與一般分割區類似

使用swapon 

```
swapon /dev/mapper/vg1-pub1
```

放大與縮小

 

```
lvresize –size 20M /dev/mapper/vg1-pub1
```

放大或縮小後須重新格式化 

```
mkswap /dev/mapper/vg1-pub1
```
