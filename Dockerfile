# 使用较小的基础镜像
FROM ubuntu:22.04

# 设置环境变量，避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 更新系统并安装必要的软件包
RUN apt-get update
# RUN apt-get install -y --no-install-recommends \
#     wget unzip systemd vim sudo curl \
#     && apt-get clean \
#     && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN apt-get install -y --no-install-recommends \
    wget unzip systemd sudo curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


COPY ./club/entrypoint.sh /club/entrypoint.sh
COPY ./club/easytier.sh /tmp/easytier.sh

# 设置工作目录
WORKDIR /root

# 设置执行权限
RUN chmod +x /club/entrypoint.sh

# 设置入口点
ENTRYPOINT ["/club/entrypoint.sh"]

# 设置默认命令
# CMD ["/usr/bin/supervisord", "-n", "-c", "/root/supervisord/supervisord.conf"]