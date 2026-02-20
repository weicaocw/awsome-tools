# Remote Mount Helper

This directory contains `script.sh`, which defines two shell functions:

- `codein <host>`: mounts `<host>:/root/autodl-tmp` to `$HOME/autodl/<host>` using `sshfs`.
- `disconnect <host>`: unmounts and cleans up the local mount point for `<host>`.

## Usage

1. Load the functions into your current shell:

```bash
source script.sh
```

2. Mount a remote host:

```bash
codein gpuhub
```

3. Enter the mounted directory:

```bash
cd ~/autodl/gpuhub
```

4. Disconnect and unmount when done:

```bash
disconnect gpuhub
```

## Notes

- This script expects SSH host aliases (for example `gpuhub`) to be configured in `~/.ssh/config`.
- Required tools: `sshfs` and a working unmount command (`diskutil` on macOS, or `umount` fallback).

# How to mount remote directory to local directory
You will need **macFUSE** (the file system driver) and **sshfs-mac** (the mounting tool).

1. **Install macFUSE:**
   Download and install the latest release from the [macFUSE official website](https://macfuse.github.io/).
   *Note for Apple Silicon (M1/M2/M3) users:* macFUSE requires a kernel extension. You must boot your Mac into Recovery Mode, access the **Startup Security Utility**, and enable **Reduced Security** to allow user management of kernel extensions from identified developers. 
   
   After restarting, go to **System Settings > Privacy & Security** and explicitly "Allow" system software from developer "Benjamin Fleischer".

2. **Install SSHFS:**
   Use Homebrew to install the macOS-compatible version of SSHFS:
   ```bash
   brew install gromgit/fuse/sshfs-mac


