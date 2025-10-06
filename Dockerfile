# Use a lightweight Debian base
FROM debian:bullseye

# Install necessary packages
RUN apt-get update && apt-get install -y \
    wget unzip xvfb fluxbox x11vnc websockify chromium \
    supervisor python3 && \
    rm -rf /var/lib/apt/lists/*

# Install noVNC properly
RUN apt-get update && apt-get install -y wget unzip && \
    mkdir -p /opt/novnc && \
    wget -O /opt/novnc.zip https://github.com/novnc/noVNC/archive/refs/heads/master.zip && \
    unzip /opt/novnc.zip -d /opt/ && \
    mv /opt/noVNC-master/* /opt/novnc && \
    rm /opt/novnc.zip

# Copy supervisor configuration
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose noVNC web port
EXPOSE 8080

# Start Supervisor to manage all background processes (VNC, noVNC, Fluxbox, etc.)
CMD ["/usr/bin/supervisord"]
