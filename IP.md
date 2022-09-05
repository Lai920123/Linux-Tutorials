# ip

### 查看ip

```python
ip addr 
```

### 查看mac

```python
ip link
```

### 查看路由

```python
ip route
```

### 查看ARP Table

```python
ip neigh
```

### 新增IP

```python
ip addr add 192.168.1.100/24 dev ens33
#新增完之後需要開啟
ip link dev ens33 up
```

### 刪除IP

```python
ip addr del 192.168.1.100/24 dev ens33
```

### 新增預設閘道

```python
ip route add default via 192.168.1.254 dev ens33
```

### 刪除預設閘道

```python
ip route del default via 192.168.1.254 dev ens33
```

### 新增路由

```python
ip route add 0.0.0.0/0 via 123.0.1.1
```

### 刪除路由

```python
ip route del 0.0.0.0/0 via 123.0.1.1
```

### 開啟網卡

```python
ip link set ens33 up 
```

### 關閉網卡

```python
ip link set ens33 down
```