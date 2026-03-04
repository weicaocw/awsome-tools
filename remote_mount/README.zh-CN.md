# 远程挂载助手

本目录包含 `script.sh`，其中定义了两个 shell 函数：

- `codein <host>`：使用 `sshfs` 将 `<host>:/root/autodl-tmp` 挂载到 `$HOME/autodl/<host>`。
- `disconnect <host>`：卸载并清理 `<host>` 对应的本地挂载点。

## 用法

1. 将函数加载到当前 shell：

```bash
source script.sh
```

2. 挂载远程主机：

```bash
codein gpuhub
```

3. 进入挂载目录：

```bash
cd ~/autodl/gpuhub
```

4. 使用完成后断开并卸载：

```bash
disconnect gpuhub
```

## 说明

- 该脚本要求你已经在 `~/.ssh/config` 中配置好 SSH 主机别名（例如 `gpuhub`）。
- 依赖工具：`sshfs`，以及可用的卸载命令（macOS 上为 `diskutil`，或回退到 `umount`）。

# 如何将远程目录挂载到本地目录
你需要安装 **macFUSE**（文件系统驱动）和 **sshfs-mac**（挂载工具）。

1. **安装 macFUSE：**
   从 [macFUSE 官网](https://macfuse.github.io/) 下载并安装最新版本。
   *Apple Silicon（M1/M2/M3）用户注意：* macFUSE 需要内核扩展。你必须将 Mac 启动到恢复模式，进入 **启动安全性实用工具（Startup Security Utility）**，并启用 **降低安全性（Reduced Security）**，以允许已识别开发者提供的内核扩展由用户管理。

   重启后，进入 **系统设置 > 隐私与安全性（Privacy & Security）**，并明确点击“允许（Allow）”来自开发者 “Benjamin Fleischer” 的系统软件。

2. **安装 SSHFS：**
   使用 Homebrew 安装兼容 macOS 的 SSHFS 版本：
   ```bash
   brew install gromgit/fuse/sshfs-mac
   ```
