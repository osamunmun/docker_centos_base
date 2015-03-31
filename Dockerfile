FROM centos:7

MAINTAINER osamunmun

RUN echo include_only=.jp >> /etc/yum/pluginconf.d/fastestmirror.conf
RUN echo prefer=ftp.iij.ad.jp >> /etc/yum/pluginconf.d/fastestmirror.conf

#Install yum libs
RUN yum install -y tar gcc make wget curl openssh openssh-server openssh-clients sudo man zlib-devel openssl-devel cpio expat-devel gettext-devel curl-devel gcc-c++ zlib readline readline-devel openssl ncurses-devel bzip2 zsh libyaml-devel libffi-devel gdbm-devel perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker

#Install git
ADD install-git.sh /usr/local/src/install-git.sh
RUN chmod +x /usr/local/src/install-git.sh
RUN /usr/local/src/install-git.sh

#Install rbenv
ADD install-rbenv.sh /usr/local/src/install-rbenv.sh
RUN chmod +x /usr/local/src/install-rbenv.sh
RUN /usr/local/src/install-rbenv.sh

#setup user
RUN useradd -m osamunmun
RUN echo 'osamunmun:password' | chpasswd
RUN echo 'osamunmun ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/osamunmun
RUN echo 'password' | chsh -s /bin/zsh osamunmun
ADD setup-dotfiles.sh /usr/local/src/setup-dotfiles.sh
RUN chmod +x /usr/local/src/setup-dotfiles.sh
RUN /usr/local/src/setup-dotfiles.sh

RUN /usr/bin/ssh-keygen -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key -N ""
RUN /usr/bin/ssh-keygen -t dsa -b 1024 -f /etc/ssh/ssh_host_dsa_key -N ""
RUN /usr/bin/ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key -N ""
ADD docker.pub /home/osamunmun/.ssh/authorized_keys
RUN chmod 600 /home/osamunmun/.ssh/authorized_keys
RUN chown osamunmun:osamunmun -R  /home/osamunmun

EXPOSE 22 3000
