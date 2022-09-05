# useradd

useradd -m 建立家目錄 -u 設定UID -s 設定shell -g 設定主要群組 -G 設定次要群組 骨架目錄 也就是家目錄的預設範本,位於/etc/skel 當創建使用者時,會複製此檔案內容至使用者家目錄

變更密碼 passwd  也可以直接以資料流導入 echo “Skills39” | passwd –stdin user001 若上面那種不行,可以試試看下面這個 echo “:” | chpasswd

大量更改使用者密碼 依照上面表格給予預設相同密碼,之後再讓使用者更改 先將/etc/shadow產生的密碼回寫到/etc/passwd pwunconv

大量新增使用者,密碼 在一個公司裡總是會有許多使用者的問題,創建時不可能一個一個創,所以就需要批次建立的方法 假設要建立IT01~50 echo -e IT0{1..9}“” >> username echo -e IT{10..50} >> username echo -e 代表可以使用特殊字元 發出警告聲

/sbin/nologin:只不允許系統login，其他服務還是可以登入

/bin/false:所以服務都無法使用