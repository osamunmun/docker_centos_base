docker_centos_base
==================

Docker recipe for CentOS + git + zsh + openssh.

To build,
```
docker build -q -t mad-p/centos-rails .
```
 * Note:
   * `-q` to avoid Golang's http chunk bug

Installed modules
 * sshd
 * zsh 5.0.5
 * git 1.8.5.3
 * rbenv with ruby 2.0.0-p353
 * rails
