# root-chpasswd

    若在登入Linux不知道或忘記密碼，可以使用此方法更改，開機進入grub boot loader時按下任意鍵，停止倒數，接著按下e進入編輯模式，在此處，不同linux distrubution的更改方式可能不同 

## CentOS ##

    找到開頭為linux的那行,在行尾加入rd.break 完成後按下Ctrl + x以此設定開機 進入shell後輸入passwd root會發現無法更改密碼 使用mount可以看到,這時根目錄掛載在/sysroot並且是ro(read onlu唯獨)的 需要重新掛載成可讀可寫 mount -o remount,rw /sysroot 再次使用mount可以看到已經更改為rw(read,write可讀可寫) chroot目錄到/sysroot chroot /sysroot 接著使用passwd root更改密碼 因為selinux並沒有啟用對所有檔案的變更,所以可能造成context不正確,為了確保開機時重新設定selinux context,需要在跟目錄下產生隱藏檔 touch /.autorelabel exit重新開機(會等一段時間是正常的)

## Debian ##

    開機進入grub boot loader時按下任意鍵,停止倒數 選擇Advanced options for Debian GNU/Linux 選擇Debian GNU/Linux,with Linux 5.10.0-13-amd64 (recovery mode) 版本要依照你做此動作時的版本,通常不會跟我一樣 案 ‘e’ 編輯 找到linux開頭,在行尾更改為rw single init=/bin/bash Ctrl + x 以此設定開機 passwd root更改root密碼 重新啟動就完成了

## GRUB2設定密碼 ##

    為了不讓有心人士經由編輯核心檔案去修改root密碼,可以使用指令來設定GRUB2的密碼 
    grub2-setpassword Enter password: test123 Confirm password: test123 但其實GRUB2設定密碼也是有辦法破除的,請看以下

BIOS也可設定密碼,防止人員亂改 但BIOS也可以拔電池來重製

