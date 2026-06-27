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
    && apt-get clean

RUN mkdir -p ~/.vnc

EXPOSE 6080

CMD ["sh", "-c", "Xvfb :1 -screen 0 1024x768x16 & export DISPLAY=:1 && xfce4-session & x11vnc -forever -shared -rfbport 6080 -nopw -bg && tail -f /dev/null"]
