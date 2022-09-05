# GRUB2

GRUB2設定密碼 為了不讓有心人士經由編輯核心檔案去修改root密碼,可/以使用指令來設定GRUB2的密碼 

```
grub2-setpassword Enter password: test123 Confirm password: test123 
```

但其實GRUB2設定密碼也是有辦法破除的,請看以下

BIOS也可設定密碼,防止人員亂改 但BIOS也可以拔電池來重製

所以說只能依靠物理防護了,密碼還是都設吧,盡量降低有人想搞破壞的想法