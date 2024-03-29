FROM sadaindonesia/ubuntu-baseline:focal
ADD /sources/images/traefik_v2.5.7_linux_amd64.tar.gz /opt/traefik

# Update package list
RUN apt -y update && \
    apt -y upgrade

# Configure Command
ADD /sources/config /tmp
ADD /sources/commands /tmp
RUN dos2unix /tmp/configure-* && \
    chmod +x /tmp/configure-* && \
    sh -c /tmp/configure-traefik

# Clear Temp
RUN rm /etc/timezone && \
    echo "Asia/Jakarta" | sudo tee /etc/timezone && \
    rm -rf /tmp/* && \
    apt -y autoclean && \
    apt -yqq autoremove && \
    apt -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    touch /var/log/installed.log && \
    rm /var/log/*.log

# Container Environment
WORKDIR /home/vhosts
LABEL maintainer="Andika Muhammad Cahya <andkmc99@gmail.com>"
LABEL container="API Gateway Bridge Application (Traefik CE)"