FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    chromium-browser \
    x11vnc \
    xvfb \
    wget \
    curl \
    git \
    python3 \
    python3-pip \
    python3-venv \
    && apt-get clean

RUN git clone https://github.com/novnc/noVNC.git /opt/noVNC && \
    git clone https://github.com/novnc/websockify /opt/noVNC/utils/websockify && \
    ln -s /opt/noVNC/vnc.html /opt/noVNC/index.html

ENV PORT=6080
EXPOSE 6080

CMD ["sh", "-c", "Xvfb :1 -screen 0 1024x768x16 & export DISPLAY=:1 && xfce4-session & x11vnc -forever -shared -nopw -rfbport 5901 & /opt/noVNC/utils/novnc_proxy --vnc localhost:5901 --listen $PORT"]
