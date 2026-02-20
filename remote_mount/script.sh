codein() {
    # Check whether a hostname was provided
    if [ -z "$1" ]; then
        echo "❌ Usage error: Please provide a cloud host name. Example: codein gpuhub"
        return 1
    fi

    local host="$1"
    local mount_point="$HOME/autodl/$host"

    # 1. Safely create the base directory
    mkdir -p "$HOME/autodl"

    # 2. Check whether this path is already mounted or occupied by a stale process
    if mount | grep -q "$mount_point"; then
        echo "🔄 Detected a previous mount for $host, cleaning up safely..."
        diskutil unmount force "$mount_point" &>/dev/null || umount "$mount_point" &>/dev/null
    fi

    # 3. Ensure the mount point is an empty directory (safer than rm -rf)
    if [ ! -d "$mount_point" ]; then
        mkdir -p "$mount_point"
    fi

    # 4. Mount
    echo "🚀 Mounting $host to $mount_point ..."
    sshfs "$host:/root/autodl-tmp" "$mount_point" \
        -o auto_cache,reconnect \
        -o local,uid=$(id -u),gid=$(id -g)

    # 5. Check result
    if [ $? -eq 0 ]; then
        echo "✅ Mount successful!"
        echo "👉 Quick access: cd $mount_point"
    else
        echo "❌ Mount failed. Please check the network or your .ssh/config settings."
    fi
}

disconnect() {
    # Check whether a hostname was provided
    if [ -z "$1" ]; then
        echo "❌ Usage error: Please provide a cloud host name. Example: disconnect gpuhub"
        return 1
    fi

    local host="$1"
    local mount_point="$HOME/autodl/$host"

    if [ ! -d "$mount_point" ]; then
        echo "⚠️ Directory $mount_point does not exist. Nothing to unmount."
        return 0
    fi

    echo "🔌 Disconnecting and unmounting $host ..."

    # 1. Force unmount
    diskutil unmount force "$mount_point" 2>/dev/null || umount "$mount_point" 2>/dev/null

    # 2. Safely remove mount point
    # Note: rmdir only removes empty directories. If unmounting fails and remote files remain visible,
    # rmdir will fail, which helps protect your data.
    if rmdir "$mount_point" 2>/dev/null; then
        echo "✅ $host disconnected successfully. Cleanup complete!"
    else
        echo "⚠️ Unmount may not have completed successfully. Directory kept for data safety."
    fi
}
