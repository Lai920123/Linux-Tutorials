# UUID

UUID(Universally Unique Identifier)是Linux下的通用唯一識別碼 可以用來讓系統中的元素都能有一個唯一的識別訊息,就不會有重複的問題 ,像是Windows掛載磁碟需要指定disk number,但disk number會有被覆 蓋掉或是替換的問題,使用UUID就不會有此問題,因為UUID是直接對應設備 的。

## 查看UUID

```bash
#查看所有裝置的UUID
blkid
#指定裝置查看UUID
blkid /dev/sda1
```

## 生成UUID

若是在需要在其他方面使用UUID或是需要自行設定的話,系統也提供了亂數產生 UUID的方式。 

```bash
cat /proc/sys/kernel/random/uuid
```