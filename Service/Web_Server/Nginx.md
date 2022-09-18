# Nginx

- 設定檔參數
    - 使用Nginxconfig產生設定檔
        
        進入網頁後輸入正確參數並下載配置即可
        
        [NGINXConfig | DigitalOcean](https://www.digitalocean.com/community/tools/nginx?domains.0.server.domain=lai.com&domains.0.server.path=%2Fvar%2Fwww%2Fhtml%2F&global.app.lang=zhTW)
        
    - 手動配置
        
        Nginx設定檔分為幾個部分，分別是main、events、http、server和location，以下分別列出各部分會用到的參數用於日後查詢
        
        ```bash
        #main
        user nginx nginx; #設定Nginx worker程序執行的使用者與群組
        worker_processes auto; #Nginx工作的處理程序數，auto會自動檢測並開啟相同數量的處理程序，也可以依照核心數設定
        worker_cpu_affinity 0001 0010 0100 1000; #可將Nginx處理程序與CPU核心綁定，降低多核心切換造成的效能損耗，範例設定值代表四核心並且開啟一個處理程序就會綁定到一顆核心
        worker_rlimit_nofile 65535; #一個Nginx處理程序最多可開啟的檔案描述符號數目
        error_log /var/log/nginx/error.log info; #錯誤記錄檔
        pid /var/log/nginx/nginx.pid; #Process ID儲存位置
        #events
        events {
            
        }
        #http，一個http中可以有多個server，server繼承main，location繼承server
        http {
            server{
                location {
                
                }   
            }
            server {
                location {
                
                }
            }
        }
        ```
        
    
- 安裝方式
    
    使用原始碼安裝的話，設定檔路徑為/usr/local/nginx/conf，使用apt的話路徑位於/etc/nginx/
    
    ```powershell
    #使用apt，安裝pcre，讓nginx使用rewrite，安裝zlib，讓nginx使用gzip模組
    apt -y install nginx pcre zlib 
    #使用原始碼
    git clone https://github.com/PhilipHazel/pcre2.git
    tar zxvf nginx-1.22.0.tar.gz
    cd nginx-1.22.0
    ./configure 
    make
    make install 
    ```
    
- 開機自啟
    
    使用原始碼安裝的話，預設是沒有nginx.service可以使用的，所以需要自己寫一個
    
    ```bash
    #使用vim編輯
    vim /lib/systemd/system/nginx.service
    #編輯以下內容
    [Unit]
    Descripton=nginx #描述
    After=network.target #服務類別
    
    [Service] #關於開機、重載、停止必須使用絕對路徑
    Type=forking #於後台運行
    ExecStart=/usr/local/nginx/sbin/nginx
    ExecReload=/usr/local/nginx/sbin/nginx -s reload
    ExecStop=/usr/local/nginx/sbin/nginx -s quit
    PrivateTmp=true #給服務分配獨立臨時空間
    
    [Install]
    WantedBy=multi-user.target
    ```
    
- 指令
    
    ```bash
    #開啟Nginx
    nginx 
    #快速關閉Nginx，可能不保存相關信息
    nginx -s stop
    #平穩關閉Nginx，保存相關信息
    nginx -s quit
    #重載Nginx
    nginx -s reload
    #測試配置文件是否正確
    nginx -t
    #顯示nginx版本
    nginx -V
    ```
    
- 變數
    
    ```bash
    #變數，例如http://localhost:8000/abc1/abc2/abc3/index.php
    $args #request的參數
    $document_root #目前網頁根目錄的值
    $uri #request中的URL
    $document_uri #和uri相同
    $document_root = /var/www/html
    $host = localhost #與request標頭
    $limit_rate #限制連接速率
    $request #用戶端請求地址
    $request_method #等於request的method，可能為GET、POST等
    $remote_addr #用戶端IP
    $remote_port #用戶端port
    $remote_user #使用者名稱
    $request_filename = /abc1/abc2/abc3/index.php#目前請求的檔案路徑名稱
    $request_uri = /abc1/abc2/abc3/index.php #含有參數的完整url
    $http_name #匹配header欄位，後半段name可以換成任何欄位，如需獲得accept-language，更改為$http_accept_language即可
    $http_cookie #請求的所有cookie
    $http_host
    $http_user_agent
    $http_x_forwarded_for 
    $query_string #與args相同
    $server_name #到達的Server name
    $server_port = 8000 #到達的Server Port
    ```
    
- 實例
    
    ### Default_Server
    
    - 使用方法
        
        Nginx的default_server可以指定預設的server用於處理沒有匹配到server_name的請求，如果沒有定義，就會選取第一個server作為default_server
        
        ```bash
        #將未綁定的域名或使用IP訪問的請求重定向至403
        server {
            listen 80 default_server;
            listen [::]:80 default_server;
            server_name _;
            return 403;
        }
        ```
        
    
    ### 防止駭客利用版本漏洞進行攻擊
    
    - 使用方法
        
        在http中加入以下行，加入後之後的請求Header中不會顯示出版本號
        
        ```bash
        server_tokens off;
        ```
        
    
    ### 使用HTTPS
    
    - 正常申請流程
        
        ### 產生請求檔
        
        ```bash
        #生成金鑰
        openssl genrsa -out server.key 2048
        #產生憑證請求檔，輸入以下指令之後再將各項資訊填完就會產生請求檔
        openssl req -new -key server.key -out certreq.txt
        -------------------------------------------------------
        Country Name:國家
        State or Province Name:州或省，台灣的話直接Enter就好
        Locality Name:城市
        Organization Name:組織名
        Organization Unit Name:單位名
        Common name:網站FQDN
        Email address:電子郵件
        challenge password:(可以省略，按Enter)
        optional company name:(可以省略，按Enter)
        ```
        
        ### 申請憑證
        
        打開瀏覽器，輸入https://server3.lai.com/certsrv(申請憑證的網址，實際的跟這裡不同)，點選Request a certificate
        
        ![Untitled](Nginx%20d7f5c7fc40134c1dbd202ace2ecf7055/Untitled.png)
        
        Advanced certificate request
        
        ![Untitled](Nginx%20d7f5c7fc40134c1dbd202ace2ecf7055/Untitled%201.png)
        
        貼上剛剛生成的請求檔，Certificate Template選擇Web Server，接著按Submit
        
        ![Untitled](Nginx%20d7f5c7fc40134c1dbd202ace2ecf7055/Untitled%202.png)
        
        等待CA頒發憑證，等頒發後回到此頁面並點選View the status of a pending certificate request
        
        ![Untitled](Nginx%20d7f5c7fc40134c1dbd202ace2ecf7055/Untitled.png)
        
        下載憑證
        
        ![Untitled](Nginx%20d7f5c7fc40134c1dbd202ace2ecf7055/Untitled%203.png)
        
        ### 憑證格式轉換
        
        因下載下來的憑證格式為cer，cer是Windows使用的格式，Linux發行版中需要將cer轉成crt
        
        ```bash
        openssl x509 -in certnew.cer -out certnew.crt -inform DER
        ```
        
        ### 將憑證寫入設定檔
        
        ```bash
        server {
            listen 443 ssl default_server;
            listen [::]:443 ssl default_server;
            ssl_certificate /etc/nginx/certnew.crt; #下載的憑證
            ssl_certificate_key /etc/nginx/server.key; #生成的私鑰
        }
        ```
        
    - 使用Let's Encrypt
        
        ### 安裝套件
        
        ```bash
        apt -y install certbot
        ```
        
    
    ### 反向代理
    
    - 簡介
        
        反向代理簡單來說就是代替伺服器接收請求，再轉發至伺服器，跟正向代理的差別是，正向代理是代理伺服器替用戶發送請求，再轉發至目的地
        
    - 反向代理的優點
        1. 儲存快取：在反向代理第一次向伺服器請求並得到回覆後，會將回復的信息儲存在快取中，下次用戶詢問時若是已經有快取，就可以由代理伺服器回應
        2. 負載平衡：
    - 單台伺服器反向代理
        
        ![Untitled](Nginx%20d7f5c7fc40134c1dbd202ace2ecf7055/Untitled%204.png)
        
        ### Proxy Server
        
        ```bash
        http {
            #http reverse proxy
            server {
                listen 80;
                server_name  www.lai.com;
                location / {
                    proxy_pass                         http://123.0.1.2:80;
                    proxy_set_header Host              $host:$server_port;
                    proxy_set_header X-Forwarded-For   $remote_addr;
                    proxy_set_header X-Forwarded-Proto $scheme;
                }
            }
            #https reverse proxy
            server {
                listen 443 ssl;
                listen [::]:443 ssl;
                server_name www.lai.com;
                ssl_certificate /etc/nginx/key/certnew.crt;
                ssl_certificate_key /etc/nginx/key/server.key;
                location / {
                    proxy_pass                         http://123.0.1.2:80;
                    proxy_set_header Host              $host:$server_port;
                    proxy_set_header X-Forwarded-For   $remote_addr;
                    proxy_set_header X-Forwarded-Proto $scheme;
                }
            }
        }
        ```
        
    - 多台伺服器反向代理與負載平衡
        
        多台反向代理可以只使用一個外部IP，並利用server_name的方式轉發到背後的Web Server上，雖然只使用一個外部IP，不過記得還是要申請多個域名才可使用
        
        ![Untitled](Nginx%20d7f5c7fc40134c1dbd202ace2ecf7055/Untitled%205.png)
        
        ### Proxy Server
        
        ```bash
        http {
            #轉發至這兩台Server的80 port
            upstream www1 {
                ip_hash; #記住來源ip，下次請求時導向訪問過的server
                server 192.168.1.100:80;
                server 192.168.1.101:80;
            }
            #轉發至這台Server的80 port
            upstream www2 {
                ip_hash;
                server 192.168.1.102:80;
            server {
                listen 80;
                server_name www1.lai.com;
                location / {
                    proxy_pass http://www1;
                    proxy_set_header Host $http_host;
                }
            }
            server {
                listen 80;
                server_name www2.lai.com;
                location / {
                    proxy_pass http://www2;
                    proxy_set_header Host $http_host;
                }
            }
        }
        
        ```
        
    
    ### 重導向
    
    - http強制重導向至https
        
        ```bash
        server {
            listen 80;
            server_name www.lai.com;
            rewrite ^ https://$http_host$request_uri? permanent;
        }
        
        server {
            listen 443 ssl;
            server_name www.lai.com;
            ssl_certificate /etc/nginx/key/certnew.crt;
            ssl_certificate_key /etc/nginx/key/server.key;
        }
        ```
        
    - http反向代理並強制重導向至https
        
        ```bash
        http {
            upstream www1 {
                ip_hash;
                server 192.168.1.100:80;
                server 192.168.1.101:80;
            }
            upstream www2 {
                ip_hash;
                server 192.168.1.102:80;
            }
            server_tokens off;
        
            server {
                listen 80;
                server_name www1.example.com;
                rewrite ^ https://$http_host$request_uri? permanent;
            }
        
            server { 
                listen 443 ssl;
                server_name www1.example.com;
                ssl_certificate /etc/nginx/key/certnew.crt;
                ssl_certificate_key /etc/nginx/key/server.key;
                location / {
                    proxy_pass http://www1;
                    proxy_set_header Host $http_host;
                }
            }
        
            server {
                listen 80;
                server_name www2.example.com;
                rewrite ^ https://$http_host$request_uri? permanent;
            }
        
            server { 
                listen 443 ssl;
                server_name www2.example.com;
                ssl_certificate /etc/nginx/key/certnew.crt;
                ssl_certificate_key /etc/nginx/key/server.key;
                location / {
                    proxy_pass http://www2;
                    proxy_set_header Host $http_host;
                }
            }
        }
        ```