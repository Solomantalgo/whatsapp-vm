FROM debian:bullseye

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget unzip xvfb fluxbox x11vnc websockify chromium \
    supervisor python3 && \
    rm -rf /var/lib/apt/lists/*

# Install noVNC
RUN mkdir -p /opt/novnc && \
    wget -qO- https://github.com/novnc/noVNC/archive/refs/heads/master.zip | unzip -d /opt/ && \
    mv /opt/noVNC-master/* /opt/novnc

# Copy supervisor config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose noVNC web port
EXPOSE 8080

# Start supervisor
CMD ["/usr/bin/supervisord"]
