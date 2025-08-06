#!/bin/sh
# 进入工作目录
cd /root

# 创建初始化标记文件所在的目录
mkdir -p /root/init

# 检查是否首次启动（通过检查标记文件）
if [ ! -f "/root/init/.initialized" ]; then
    echo "首次启动，执行初始化操作..."

    cp -r /club/configs/supervisord.conf /root/supervisord/supervisord.conf

    # 创建标记文件，表示已初始化
    touch /root/init/.initialized
    echo "初始化完成"
else
    echo "检测到已初始化，跳过初始化步骤..."
fi

# 每次启动时都要执行的操作

# 执行传入的命令，通常是启动 supervisord
exec "$@"