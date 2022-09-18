# bashrc profile 差異 #

### login shell ###
    交互式shell，shell等待輸入，並且執行提交的命令，當執行結束時，shell中止

### non-login shell ###
    非交互式shell，shell不予用戶進行交互，而是讀取文件中的命令並執行，當讀到文件結尾時，shell中止

### /etc/profile ###
    為每個用戶設置環境訊息，當用戶登入時，該檔案被執行，並且從/etc/profile.d配置文件中蒐集shell的配置
### ~/.profile ###
    每個用戶都可輸入自己專屬的shell訊息，當用戶登入時，僅會執行一次，預設情況下，會設置環境變數，並執行用戶的~/.bashrc
### /etc/bashrc ###
    為每個運行shell的用戶執行文件，當shell打開時，會執行/etc/bashrc中的命令
### ~/.bashrc ###
    配置用戶專屬的執行文件，當shell打開時，會執行~/.bashrc中的命令

