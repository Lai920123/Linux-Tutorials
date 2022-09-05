# Compression

## tar :

```bash
參數
	-c 打包檔案
	-x 解開壓縮檔
	-t 檢視壓縮檔的內容
	-z 使用gzip壓縮
	-v 顯示執行過程
	-p 使用絕對路徑
	-f 指定壓縮檔檔名
```

```
打包:
	tar cvf <filename.tar> <source>
```

```
解包:
	tar xvf <filname.tar>
```

## gz

```
壓縮:
	gzip FileName
```

```
解壓縮:
	gzip -d FileName.gz
```

## tar.gz

```
壓縮:
	tar zcvf FileName.tar.gz DirName
```

```
解壓縮：
	tar zxvf FileName.tar.gz
```

## bz

```
解壓縮：
	bzip2 -d FileName.bz
```

## tar.bz

```
解壓縮：
	tar jxvf FileName.tar.bz
```

## bz2

```
壓縮：
	bzip2 -z FileName
```

```
解壓縮:
	bunzip2 FileName.bz2
```

## tar.bz2

```
壓縮： 
	tar jcvf FileName.tar.bz2 DirName 
```

```
解壓縮： 
	tar jxvf FileName.tar.bz2
```

## tar.bz2

```
壓縮： 
	tar jcvf FileName.tar.bz2 DirName 
```

```
解壓縮： 
	tar jxvf FileName.tar.bz2
```

## xz

```
壓縮： 
	xz -z FileName
```

```
解壓縮：
  xz -d FileName.xz
```

## tar.xz

```
壓縮： 
	tar Jcvf FileName.tar.xz DirName
```

```
解壓縮：
  tar Jxvf FileName.tar.xz
```

## Z

```
壓縮： 
	compress FileName
```

```
解壓縮：
  uncompress FileName.Z
```

## tar.Z

```
壓縮： 
	tar Zcvf FileName.tar.Z DirName
```

```
解壓縮：
  tar Zxvf FileName.tar.Z
```

## tgz

```
壓縮： 
	tar zcvf FileName.tgz FileName
```

```
解壓縮： 
	tar zxvf FileName.tgz
```

## tar.tgz

```
壓縮： 
	tar zcvf FileName.tar.tgz FileName
```

```
解壓縮： 
	tar zxvf FileName.tar.tgz
```

## 7z

```
壓縮： 
	7z a FileName.7z FileName
```

```
使用密碼 (PASSWORD) 壓縮： 
	7z a FileName.7z FileName -pPASSWORD
```

```
解壓縮： 
	7z x FileName.7z
```

## zip

```
壓縮：
	zip -r FileName.zip DirName
```

```
解壓縮： 
	unzip FileName.zip
```

## rar

```
壓縮： 
	rar a FileName.rar DirName
```

```
解壓縮 1： 
	rar e FileName.rar
```

```
解壓縮 2：
	unrar e FileName.rar
```

```
解壓縮 3：
	在指定目錄內解壓縮。 rar x FileName.rar DirName
```

## lha

```
壓縮： 
	lha -a FileName.lha FileName
```

```
解壓縮： 
	lha -e FileName.lha
```

## zst

```
壓縮：
	zst FileName
```

```
解壓縮： 
	zstd -d FileName.zst
```

## tar.zst

```
壓縮： 
	tar -I zst -cvf FileName.tar.zst DirName tar -I zst -cvf FileName.tar.zst File1 File2
```

```
解壓縮： 
	tar -I zstd -xvf FileName.tar.zst
```