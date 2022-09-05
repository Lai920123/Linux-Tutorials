# MySQL

- 安裝套件
    
    [MySQL :: MySQL Community Downloads](https://dev.mysql.com/downloads/)
    
    ### Debian
    
    ```bash
    #從官網下載repository並安裝
    apt -y install ./mysql-apt-config_0.8.23-1_all.deb
    #更新套件源
    apt update
    #安裝MySQL Server
    apt -y install mysql-server
    ```
    
    安裝過程會請你設定Root密碼
    
    ![Untitled](MySQL%203587cf219d3c4da1a9a5d154fb37012c/Untitled.png)
    
    確認
    
    ![Untitled](MySQL%203587cf219d3c4da1a9a5d154fb37012c/Untitled%201.png)
    
    使用更強的加密
    
    ![Untitled](MySQL%203587cf219d3c4da1a9a5d154fb37012c/Untitled%202.png)
    
    ### CentOS
    
    ```bash
    dnf -y install ./mysql80-community-release-el9-1.noarch.rpm
    ```
    
- 常用指令
    
    ### 登入MySQL
    
    ```bash
    #登入本地電腦
    mysql -u root -p
    #登入遠端電腦，參數不必空格
    mysql -h 123.0.1.1 -u root -p P@ssw0rd 
    ```
    
    ### 修改密碼
    
    ```powershell
    mysqladmin -u root -p <舊密碼> password <新密碼>
    ```
    
    ### 顯示狀態
    
    ```sql
    #顯示狀態
    status
    #顯示版本
    select version()
    ```
    
    ### 資料庫管理
    
    ```sql
    #顯示資料庫列表
    show databases;
    #創建名為test_db的資料庫，字符編碼為gbk
    create database test_db character set gbk; 
    #刪除名為test_db的資料庫
    drop database test_db;
    #選擇指定的資料庫
    use test_db;
    ```
    
    ### 常用資料型態
    
    | 數字 | 儲存大小 | 最小值(Signed/Unsigned) | 最大值(Signed/Unsigned) |
    | --- | --- | --- | --- |
    | tinyint | 1Bytes | -128 | 127 |
    |  |  | 0 | 255 |
    | smallint | 2Bytes | -32768 | 32767 |
    |  |  | 0 | 65535 |
    | mediumint | 4Bytes | -8388608 | 8388607 |
    |  |  | 0 | 16777215 |
    | int | 8Bytes | -2147483648 | 2147483647 |
    |  |  | 0 | 4294967295 |
    | 浮點數 | 儲存大小 | 精度 | 精確性 |
    | float(M,D) | 4Bytes | 單精度 | 不精確，容易精度丟失 |
    | double(M,D) | 8Bytes | 雙精度 | 比Float精確 |
    | 日期與時間 | 範例 | 精確性 | 註解 |
    | date | 2015-05-01 | 年月日 |  |
    | time | 11:12:00 | 時分秒 |  |
    | datetime | 2022-07-27 08:28:00 | 年月日時分秒 | 不會根據系統時區進行轉換 |
    | timestamp | 2022-07-27 08:28:00 | 年月日時分秒 | 會根據系統時區進行轉換 |
    | year |  |  |  |
    | 字串 |  |  |  |
    | char |  |  |  |
    | varchar |  |  |  |
    | tinytext |  |  |  |
    | text |  |  |  |
    | mediumtext |  |  |  |
    | longtext |  |  |  |
    
    ### 資料表管理
    
    ```sql
    #查看資料表
    show tables;
    #查看資料表欄位資訊
    describe <資料表名稱>
    #創建資料表
    create table user_account (
    username char(100),
    password text
    );
    #刪除資料表
    drop tables user_account;
    #修改資料表欄位
    alter table <資料表名稱> change column <原欄位名稱> <要修改的欄位名稱> <資料型態>;
    #新增資料表欄位
    alter table <資料表名稱> add column <欄位名稱> <資料型態>;
    #刪除資料表欄位
    alter table <資料表名稱> drop column <欄位名稱>;
    
    ```