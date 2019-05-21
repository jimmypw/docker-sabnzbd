FROM debian

ENV SABDLURL="https://github.com/sabnzbd/sabnzbd/releases/download/2.3.8/SABnzbd-2.3.8-src.tar.gz"
ENV UNRARSRC="https://www.rarlab.com/rar/unrarsrc-5.7.1.tar.gz"
ENV PYTHONIOENCODING=utf-8

RUN useradd -m -d /opt/sabnzbd -s /bin/bash sabnzbd

RUN apt-get update; \
        apt-get install -y \
        vim curl python python-pip python-cheetah par2 python-cryptography python-yenc zip unzip p7zip-full locales; \
        pip install sabyenc; \
        echo "en_GB.UTF-8 UTF-8" > /etc/locale.gen; \
        locale-gen

ENV LC_ALL=en_GB.utf8

RUN curl -L -s -o /usr/local/src/unrar.tar.gz ${UNRARSRC}; \
        mkdir /usr/local/src/unrar; \
        tar -C /usr/local/src/unrar --strip-components=1 -xf /usr/local/src/unrar.tar.gz
WORKDIR /usr/local/src/unrar
RUN make && make install
RUN apt install -y strace

USER sabnzbd
WORKDIR /opt/sabnzbd
RUN curl -L -s -o sabnzbd.tar.gz ${SABDLURL}; \
        mkdir sabnzbd; \
        tar -C sabnzbd --strip-components=1 -xf sabnzbd.tar.gz

EXPOSE 8080

#ENTRYPOINT /usr/bin/strace /usr/bin/python /opt/sabnzbd/sabnzbd/SABnzbd.py --server 0.0.0.0:8080 --config-file /opt/sabnzbd/config
ENTRYPOINT  /usr/bin/python /opt/sabnzbd/sabnzbd/SABnzbd.py --server 0.0.0.0:8080 --config-file /opt/sabnzbd/config
