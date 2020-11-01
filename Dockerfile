FROM ubuntu

ENV VNCPWD www

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN apt update && \
    apt install -y software-properties-common && \
    add-apt-repository -y ppa:obsproject/obs-studio && \
    apt install -y binutils sudo xvfb x11vnc ffmpeg qt5-default obs-studio curl && \
    strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5
    #https://github.com/dnschneid/crouton/wiki/Fix-error-while-loading-shared-libraries:-libQt5Core.so.5

RUN groupadd user && useradd -m -g user user && \
    sudo echo -e "\nuser ALL=(ALL:ALL) ALL" >> /etc/sudoers && \
    mkdir /home/user/.vnc && \
    x11vnc -storepasswd $VNCPWD /home/user/.vnc/passwd && \
    chown -R user:user /home/user/.vnc/

RUN apt install -y npm && npm i -g n && \
     n lts

#USER user

COPY . /

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 5900
