### Checksum ###
checksum用來進行驗證在傳輸過程中是否遭到修改，使用雜湊值來驗證資料的完整性

### md5 ### 
```bash
touch test.txt #創建一個文字檔
md5sum test.txt > test.md5sum #使用md5sum產生校驗碼並用資料流導向至另一個檔案中
md5sum -c test.md5sum #使用剛剛產生的校驗碼進行校驗
```
### sha256 ###
操作方法與md5相同
```bash
touch test.txt #創建一個文字檔
sha256sum test.txt > test.sha256sum #使用sha256sum產生校驗碼並用資料流導向至另一個檔案中
sha256sum -c test.sha256sum #使用剛剛產生的校驗碼進行校驗

```