FROM sadaindonesia/ubuntu-baseline:focal

# Update package list
RUN apt -y update && \
    apt -y upgrade

# Configure Command
ADD /sources/commands /tmp
RUN dos2unix /tmp/configure-* && \
    chmod +x /tmp/configure-* && \
    sh -c /tmp/configure-traefik && \
    sh -c /tmp/configure-nodejs && \
    sh -c /tmp/configure-healthcheck && \
    sh -c /tmp/configure-container

# Add Health Check
ADD /sources/healthcheck /opt/healthcheck

# Clear Temp
RUN rm /etc/timezone && \
    echo "Asia/Jakarta" | sudo tee /etc/timezone && \
    rm -rf /tmp/* && \
    apt -y autoclean && \
    apt -yqq autoremove && \
    apt -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm /var/log/*.log

# Container Environment
WORKDIR /home/vhosts
HEALTHCHECK CMD node /opt/healthcheck/monitor.js
LABEL maintainer="Andika Muhammad Cahya <andkmc99@gmail.com>"
LABEL container="API Gateway Bridge Application (Traefik CE)"