# Systemd

目前大多數Linux發行版都已經使用systemd替換sysV

## Daemon和Service的差異

```bash
Daemon:
	為啟用服務的程序
Service:
	服務本身，但沒有Daemon就不會有服務
```

## Systemd

Systemd可以管理所有系統資源，系統資源單位為unit

```bash
unit file為unit的單元文件,systemd會透過單元文件來控制unit啟動和其他動作
例如:
    ssh是一個unit,sshd.service是單元文件
Unit File類型
Type       unit file name        description 
Service    .service            啟動服務,關閉,重啟
Target     .target                定義target
Device     .device         /dev下的設備,用於定義設備
Mount      .mount        定義掛載點,可以替代/etc/fstab
Automount  .automount         自動控制掛載文件系統
Path       .path             監控指定目錄和文件變化
Scope      .scope  Systemd運行時產生的，描述一些系統服務的分組信息
Slice      .slice                CGroup的樹
Snapshot   .snapshot    系統快照,可以切回已經創建好的快照
Socket     .socket           監控來自網路的數據消息
Swap       .swap              定義swap的交換分區
Timer      .timer        配置特定時間觸發,可替代crontab
```

## System使用實例

### 查看狀態

```bash
#列出單元文件狀態
systemctl list-unit-files 
#進一步過濾
systemctl list-unit-files | grep networking
```

### 變更主機名稱

```bash
hostnamectl set-hostname PC1
```

### 管理服務

```bash
#開啟
systemctl start networking
#停止
systemctl stop networking 
#重載
systemctl reload networking 
#重啟
systemctl restart networking 
```