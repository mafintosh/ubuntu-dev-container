FROM ubuntu:xenial
RUN rm -f /etc/resolv.conf && echo '8.8.8.8' > /etc/resolv.conf
RUN echo deb http://security.ubuntu.com/ubuntu xenial main restricted > /etc/apt/sources.list \
  && echo deb http://security.ubuntu.com/ubuntu xenial universe >> /etc/apt/sources.list \
  && echo deb http://security.ubuntu.com/ubuntu xenial multiverse >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install -y git vim curl build-essential wget bash-completion screen man libtool \
  autoconf automake python help2man python-setuptools
RUN mkdir -p /opt/mininet \
  && git clone git://github.com/mininet/mininet.git /opt/mininet \
  && cd /opt/mininet \
  && git checkout 2.2.2 \
  && make install \
  && apt-get install -y openvswitch-testcontroller openvswitch-common openvswitch-switch \
  && cp /usr/bin/ovs-testcontroller /usr/bin/ovs-controller
RUN curl -fs https://raw.githubusercontent.com/mafintosh/node-install/master/install | sh \
  && node-install 8.9.3
COPY home /root/home
ENV UBUNTU_USER="$USER" UBUNTU_PASSWD="qweqwe" UBUNTU_HOSTNAME="$(hostname)"
RUN adduser --disabled-password --gecos "" $UBUNTU_USER && echo root:$UBUNTU_PASSWD | chpasswd \
  && echo $UBUNTU_USER:$UBUNTU_PASSWD | chpasswd \
  && echo "$UBUNTU_USER ALL=(ALL) NOPASSWD:ALL" > /tmp/container-user \
  && mv /tmp/container-user /etc/sudoers.d/container-user \
  && cp /root/home/.bashrc /home/$UBUNTU_USER/.bashrc \
  && cp /root/home/.git-prompt.sh /home/$UBUNTU_USER/.git-prompt.sh \
  && rm -rf /root/home \
  && chown $UBUNTU_USER:$UBUNTU_USER -R /home/$UBUNTU_USER \
  && echo 127.0.0.1 $UBUNTU_HOSTNAME >> /etc/hosts \
  && echo 127.0.0.1 container.img >> /etc/hosts
