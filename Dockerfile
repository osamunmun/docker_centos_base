FROM centos

MAINTAINER Kaoru Maeda <kaoru.maeda@gmail.com> mad-p

RUN yum install -y tar gcc make wget curl openssh openssh-server openssh-clients sudo

RUN yum install -y zlib-devel openssl-devel cpio expat-devel gettext-devel curl-devel perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker
ADD install-git.sh /usr/local/src/install-git.sh
RUN chmod +x /usr/local/src/install-git.sh; /usr/local/src/install-git.sh |& tee /usr/local/src/install-git.log

RUN yum install -y ncurses-devel
ADD install-zsh.sh /usr/local/src/install-zsh.sh
RUN chmod +x /usr/local/src/install-zsh.sh; /usr/local/src/install-zsh.sh |& tee /usr/local/src/install-zsh.log

RUN yum -y install gcc make zlib zlib-devel readline readline-devel openssl openssl-devel curl curl-devel
ADD install-rails.sh /usr/local/src/install-rails.sh
RUN chmod +x /usr/local/src/install-rails.sh; /usr/local/src/install-rails.sh |& tee /usr/local/src/install-rails.log

EXPOSE 2222
