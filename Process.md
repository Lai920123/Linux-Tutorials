# process

程序管理 首先要知道程序是甚麼,跟程式又差在哪裡 程式(Program):簡單來說,用程式語言寫出來的就叫程式 程序(Process):執行過後的程式就稱為程序 在Linux中,要查看程序,有幾種方式,以下就示範查看程序予刪除程序的方式 父程序與子程序 舉例來說,進入系統後,你開啟了Terminal這個終端機視窗,也可以說是開啟了bash這個shell 接著在裡面執行了ls,那bash就是父程序,ls就是子程序,它們分別都有一個識別碼 可以使用ps -l來查看,用剛剛以上的範例可以看到顯示出以下(PID跟PPID都會依實際情況而不同是很正常的) PID PPID CMD 42392 42388 bash 43363 42392 ls bash的Process ID為42392,而ls的Process ID為43363且PPID(parent process ID為42392也就是bash

查看程序 ps: 參數 -aux 顯示所有包含其他使用者的詳細程序,還可以加上Z查看SELinux contexts -l 長格式,可以看到PPID

pstree:(可以更清楚的看出父程序與子程序) 參數 -a 顯示程序完整參數 -p 顯示PID -np 以PID排序並顯示PID -p  也可以直接指定PID,會列出以此程序為起始以下的樹狀圖,通常會加上-p同時顯示PID  顯示特定使用者執行的程式

刪除程序 在linux要刪除程序需要使用kill或者killall指令 kill:使用PID管理程序 參數 -l 查看信號列表 1 終端掛斷 2 中斷,等於Ctrl + C 3 退出,等於Ctrl +
9 無條件強制中止程序 15 繼續,等於fg/bg,經過kill 19關閉bg的程序後,再次開啟會在背景執行 19 暫停,等於Ctrl + Z killall:使用程序名稱管理程序 參數 跟上面相同,只是可以使用程序名稱,如 killall 9 httpd 但要注意會直接kill所有關聯的程序