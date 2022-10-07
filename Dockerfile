from parrotsec/core:latest
RUN set -ex;\
    apt-get update;\
    apt-mark hold keyboard-configuration;\
    apt-get install python3 git tightvncserver expect websockify qemu-system-x86 xfce4 dbus-x11 -y
ENV DISPLAY=:0
RUN pip3 install websockify pyngrok
RUN apt-get install xfce4-terminal htop tmate tmux -y
#----------------------
RUN mkdir /magic
RUN cd /magic&&git clone https://github.com/novnc/noVNC/
COPY . /magic
WORKDIR /magic
CMD rm /magic/Dockerfile&& Xvnc :0 -geometry 1280x720&startxfce4&python3 ngrok_.py&cd /work/noVNC && ./utils/novnc_proxy --vnc :5900 --listen ${PORT}
