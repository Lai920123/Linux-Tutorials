# export #

>export可用來管理環境變數，不過僅限於當次登入，重新啟動後會消失

## 常見使用方法 ##

```bash
#列出所有環境變數
export 
#加入路徑至環境變數PATH，修改時要注意$PATH一定要加，否則會清空原有的內容
export PATH=$PATH:/home/user/test
#刪除環境變數
export TEST=Test
#每次開啟shell時加入環境變數，將export寫入~/.bashrc即可
vim ~/.bashrc
export PATH=$PATH:/home/user/test
```