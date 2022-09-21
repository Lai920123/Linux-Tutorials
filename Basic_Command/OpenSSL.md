# OpenSSL

- 語法
    
    
- 格式說明
    
    ### 
    
- 實例
    - 產生金鑰
        
        ```bash
        #產生4096bit的rsa私鑰並已aes256加密
        openssl genrsa -out private.pem 4096
        #再使用剛剛產生的私鑰產生公鑰
        openssl rsa -in private.pem -pubout -out public.pem
        ```
        
    - 格式轉換
        
        ```bash
        #p7b轉為pem
        openssl pkcs7 -in certnew.p7b -inform DER -print_certs -out certnew.pem 
        ```