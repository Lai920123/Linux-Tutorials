# awk #

>下面直接帶入幾個常見的使用環境，讓大家能夠更好理解

## 取出使用者名稱與密碼 ##

```bash
#檔案名稱
account.txt 
#檔案內容
id  使用者名稱  地址                  密碼 
1   handmade  高雄市彌陀區安樂路2號    uHQWxbX5
2   pile      高雄市旗山區志航街9號    B5cYr75Q
3   beryl     桃園市龍潭區聖亭路32號   gwTnwXC9
4   misprint  屏東縣鹽埔鄉中正路9號    naezCKfg
5   trespass  雲林縣崙背鄉忠孝北街22號 duCEfymg
6   mullah    基隆市中山區新民路7號    84MtVZWb
7   incision  臺北市北投區振興街14號   BEGa7ahv
8   quash     高雄市燕巢區興龍路8號    WzhARtSm
9   flake     臺南市仁德區保學二街6號  Zz7wZbuh
10  dab       屏東縣內埔鄉文昌路21號   MZ2cK8AQ
```

### 使用方法 ##

```bash
awk '{print $2,$4}' account.txt #以空格為分隔輸出第二項和第四項
awk 'NR=1{print $2,$4}' account.txt #也可以將第一列拿掉，NR!=1代表不讀第一行，同樣作法可用於其他行
```

### 結果 ###

![](awk1.png)

## 取出同學的姓名與平均 ##

```bash
#檔案名稱
score.txt
#檔案內容
編號,姓名,國文,英文,數學,平均
1,小明,60,70,40,56
2,靜香,65,47,82,64
3,大雄,50,30,85,55
4,胖虎,77,84,96,85
5,小夫,10,30,25,21
```

跟上一個範例不同的是，這次是以,作為項目的分隔，所以要加上參數-F指定分隔的特殊符號


### 使用方法 ###

```bash
awk -F , '{print $2,$6}' score.txt  #-F後可以不要空格
awk -F , 'NR!=1{print $2,$6}' score.txt #也可以將第一列拿掉，NR!=1代表不讀第一行，同樣作法可用於其他行
```
