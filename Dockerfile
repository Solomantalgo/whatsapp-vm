FROM debian:bullseye

# Install required packages
RUN apt-get update && apt-get install -y \
    wget unzip xvfb fluxbox x11vnc websockify chromium supervisor python3 \
    x11-xserver-utils xdotool && \
    rm -rf /var/lib/apt/lists/*

# Install noVNC
RUN mkdir -p /opt/novnc && \
    wget -q https://github.com/novnc/noVNC/archive/refs/heads/master.zip -O /tmp/novnc.zip && \
    unzip /tmp/novnc.zip -d /opt/ && \
    mv /opt/noVNC-master/* /opt/novnc && \
    rm /tmp/novnc.zip

# Copy supervisor configuration
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose noVNC port
EXPOSE 8080

# Start supervisor
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
