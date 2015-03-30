FROM centos:7

MAINTAINER osamunmun

RUN echo include_only=.jp >> /etc/yum/pluginconf.d/fastestmirror.conf
RUN echo prefer=ftp.iij.ad.jp >> /etc/yum/pluginconf.d/fastestmirror.conf

RUN yum install -y tar gcc make wget curl openssh openssh-server openssh-clients sudo

RUN yum install -y zlib-devel openssl-devel cpio expat-devel gettext-devel curl-devel perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker
ADD install-git.sh /usr/local/src/install-git.sh
RUN chmod +x /usr/local/src/install-git.sh
RUN /usr/local/src/install-git.sh

RUN yum -y install gcc gcc-c++ make zlib zlib-devel readline readline-devel openssl openssl-devel curl curl-devel
ADD install-rbenv.sh /usr/local/src/install-rbenv.sh
RUN chmod +x /usr/local/src/install-rbenv.sh
RUN /usr/local/src/install-rbenv.sh

RUN yum install -y ncurses-devel bzip2
RUN yum install -y zsh

RUN useradd -m osamunmun
RUN echo 'osamunmun:password' | chpasswd
RUN echo 'osamunmun ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/osamunmun
RUN echo 'password' | chsh -s /bin/zsh osamunmun

RUN /usr/bin/ssh-keygen -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ""
RUN /usr/bin/ssh-keygen -t dsa -b 1024 -f /etc/ssh/ssh_host_dsa_key -N ""
RUN /usr/bin/ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ""

EXPOSE 22 3000
