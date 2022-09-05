# PPA個人套件庫

在Linux中絕大部分的套件都來自於官方套件庫，但若是需要的套件不存在於官方套件庫，就需要使用到個人套件庫

## 新增

```python
sudo add-apt-repository ppa:<套件庫名稱>
#新增完成後就可安裝個人套件庫的套件
sudo apt update
sudo apt -y install <套件名>
```

## 移除

```python
#移除套件
sudo apt autoremove --purge <套件名>
#移除PPA
sudo add-apt-repository --remove ppa:<套件庫名稱>
```