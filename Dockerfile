# 使用较小的基础镜像
FROM easytier/easytier:latest

# 设置环境变量，避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 更新系统并安装必要的软件包
RUN apk update
RUN apk add \
    wget unzip \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# 将当前目录的所有文件复制到容器的 /opt 目录下
COPY ./opt/entrypoint.sh /opt/entrypoint.sh

# 设置工作目录
WORKDIR /root

# 设置执行权限
RUN chmod +x /opt/entrypoint.sh

# 设置入口点
ENTRYPOINT ["/opt/entrypoint.sh"]