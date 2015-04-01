FROM centos:7

MAINTAINER osamunmun

RUN echo include_only=.jp >> /etc/yum/pluginconf.d/fastestmirror.conf
RUN echo prefer=ftp.iij.ad.jp >> /etc/yum/pluginconf.d/fastestmirror.conf

#Install yum libs
RUN yum install -y tar gcc make wget curl openssh openssh-server openssh-clients sudo man zlib-devel openssl-devel cpio expat-devel gettext-devel curl-devel gcc-c++ zlib readline readline-devel openssl ncurses-devel bzip2 zsh libyaml-devel libffi-devel gdbm-devel perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker

#Install MySQL
RUN yum -y install http://dev.mysql.com/get/mysql-community-release-el6-5.noarch.rpm
RUN yum -y install mysql-community-server
RUN chkconfig mysqld on
RUN service mysqld start

#Install git
ADD install-git.sh /usr/local/src/install-git.sh
RUN chmod +x /usr/local/src/install-git.sh
RUN /usr/local/src/install-git.sh

#Install rbenv
ADD install-rbenv.sh /usr/local/src/install-rbenv.sh
RUN chmod +x /usr/local/src/install-rbenv.sh
RUN /usr/local/src/install-rbenv.sh

#Install vim
RUN yum install -y ruby-devel python-devel
ADD install-vim.sh /usr/local/src/install-vim.sh
RUN chmod +x /usr/local/src/install-vim.sh
RUN /usr/local/src/install-vim.sh

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
RUN sed -i 's/Defaults    requiretty/#Defaults    requiretty/g' /etc/sudoers

#setup github publickey authentication
ADD github_rsa /home/osamunmun/.ssh/github_rsa
RUN chown osamunmun:osamunmun /home/osamunmun/.ssh/github_rsa

#setup locale
RUN localedef -f UTF-8 -i ja_JP ja_JP
RUN cp /usr/share/zoneinfo/Japan /etc/localtime

EXPOSE 22 3000

# Plz exec after build below commnads. For now these commands should be execed by manyual.

#RUN sudo -u osamunmun /usr/local/bin/vim -u /home/osamunmun/.vimrc -i NONE -c "try | NeoBundleUpdate! | finally | q!     | endtry" -e -s -V1
#RUN cd /home/osamunmun/.dotfiles/vim/bundle/vimproc
#RUN sudo -u osamunmun make
#RUN eval `ssh-agent`
#RUN ssh-add /home/osamunmun/.ssh/github_rsa
