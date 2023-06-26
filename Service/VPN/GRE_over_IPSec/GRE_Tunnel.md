# GRE Tunnel

### 附表

讓HQ和BRANCH內部網路能夠通過GRE Tunnel連通

```python
HQ     
ens33 123.0.1.1/24
ens36 10.1.1.1/24
BRANCH
ens33 123.0.1.2/24
ens36 172.16.1.1/24
tunnel interface
HQ 192.168.1.1/24
BRANCH 192.168.1.2/24
```

## HQ

### 建立tunnel

```python
ip tunnel add tunnel0 mode gre remote 123.0.1.2 local 123.0.1.1 ttl 255
```

### 新增IP

```python
ip addr add 192.168.1.1 dev tunnel0
#新增完之後需要開啟
ip link dev tunnel0 up
```

### 新增路由

```python
ip route add 172.16.1.0/24 dev tunnel0
```

## BRANCH

### 建立tunnel

```python
ip tunnel add tunnel0 mode gre remote 123.0.1.1 local 123.0.1.2 ttl 255
```

### 新增IP

```python
ip addr add 192.168.1.2 dev tunnel0
#新增完之後需要開啟
ip link dev tunnel0 up
```

### 新增路由

```python
ip route add 10.1.1.0/24 dev tunnel0
```