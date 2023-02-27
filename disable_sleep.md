# 關閉睡眠 #

>Debian預設是開啟睡眠的，這會造成有時候只是移開一下回來又必須重新登入的狀況，實務上建議是開啟，不過在練習環境將他關閉會對管理員操作較為方便

## 關閉方式 ##

```bash
systemctl umask sleep.target suspend.target hibernate.target hybrid-sleep.target
```

## 開啟方式 ##

```bash
systemctl umask sleep.target suspend.target hibernate.target hybrid-sleep.target
```

## Reference ##

https://blog.51cto.com/u_14867519/4004778