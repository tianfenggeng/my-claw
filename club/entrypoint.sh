#!/bin/sh
# 进入工作目录
cd /root

# 创建初始化标记文件所在的目录
mkdir -p /root/init

# 检查是否首次启动（通过检查标记文件）
if [ ! -f "/root/init/.initialized" ]; then
    echo "首次启动，执行初始化操作..."

    if [ ! -f "/tmp/easytier.sh"]; then
        echo "download easytier.sh"
        wget --no-check-certificate -O /tmp/easytier.sh "https://raw.githubusercontent.com/EasyTier/EasyTier/main/script/install.sh" && sudo bash /tmp/easytier.sh install --gh-proxy https://ghfast.top/
    else
        sudo bash /tmp/easytier.sh install --gh-proxy https://ghfast.top/
    fi
    echo "安装 easytier 成功，准备启动..."
    systemctl start easytier@default

    # 创建标记文件，表示已初始化
    touch /root/init/.initialized
    echo "初始化完成"
else
    echo "检测到已初始化，跳过初始化步骤..."
fi

# 每次启动时都要执行的操作

# 执行传入的命令，通常是启动 supervisord
exec "$@"


# # 进入工作目录
# cd /root

# # 创建初始化标记文件所在的目录
# mkdir -p /root/init

# # 检查是否首次启动（通过检查标记文件）
# if [ ! -f "/root/init/.initialized" ]; then
#     echo "首次启动，执行初始化操作..."

#     # 创建必要的目录
#     mkdir -p /root/webssh
#     mkdir -p /root/dufs
#     mkdir -p /root/supervisord
#     mkdir -p /root/sshd

#     # 确保日志目录存在并设置适当的权限
#     for dir in /root/webssh /root/dufs /root/sshd; do
#         mkdir -p $dir
#         touch $dir/${dir##*/}_stdout.log $dir/${dir##*/}_stderr.log
#         chmod 755 $dir
#         chmod 644 $dir/*.log
#     done

#     # 复制必要的二进制文件和配置
#     cp /club/configs/.bashrc /root/.bashrc
#     cp -r /club/bin/dufs /root/dufs
#     cp -r /club/bin/webssh /root/webssh
#     cp -r /club/configs/supervisord.conf /root/supervisord/supervisord.conf


#     wget --no-check-certificate -O /tmp/easytier.sh "https://raw.githubusercontent.com/EasyTier/EasyTier/main/script/install.sh" && sudo bash /tmp/easytier.sh install --gh-proxy https://ghfast.top/

#     echo "安装 easytier 成功，准备启动..."
#     systemctl start easytier@default

#     # 创建标记文件，表示已初始化
#     touch /root/init/.initialized
#     echo "初始化完成"
# else
#     echo "检测到已初始化，跳过初始化步骤..."
# fi

# # 每次启动时都要执行的操作

# # 配置 SSH 服务
# if [ ! -d "/var/run/sshd" ]; then
#     mkdir -p /var/run/sshd
#     chmod 0755 /var/run/sshd
# fi

# # 确保 SSH 主机密钥存在
# if [ ! -f "/etc/ssh/ssh_host_rsa_key" ]; then
#     ssh-keygen -A
# fi

# # 每次启动都设置club用户密码
# CLUB_PWD_FILE="/root/init/.club"
# if [ -f "$CLUB_PWD_FILE" ]; then
#     CLUB_PWD=$(cat "$CLUB_PWD_FILE")
# else
#     CLUB_PWD="123456"
# fi
# echo "club:$CLUB_PWD" | chpasswd

# # 执行传入的命令，通常是启动 supervisord
# exec "$@"
