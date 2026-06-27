FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    xfce4 \
    xfce4-goodies \
    xrdp \
    chromium-browser \
    wget \
    curl \
    && apt-get clean

RUN useradd -m -s /bin/bash rdpuser && \
    echo "rdpuser:password123" | chpasswd && \
    adduser xrdp ssl-cert

RUN echo "xfce4-session" > /home/rdpuser/.xsession && \
    chown rdpuser:rdpuser /home/rdpuser/.xsession

ENV PORT=3389
EXPOSE 3389

CMD ["sh", "-c", "rm -f /var/run/xrdp.pid /var/run/xrdp-sesman.pid && xrdp-sesman && xrdp --nodaemon"]
