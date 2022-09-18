# Route

## 使用route

### 新增路由

```bash
route add -net 192.168.1.0 netmask 255.255.255.0 dev eth0 
```

### 刪除路由

```bash
route del -net 192.168.1.0 netmask 255.255.255.0 dev eth0 
```

## 使用ip

### 新增路由

```python
ip route add 0.0.0.0/0 via 123.0.1.1
```

### 刪除路由

```python
ip route del 0.0.0.0/0 via 123.0.1.1
```