#!/bin/sh

# Thanks to https://gist.github.com/matthewriley/7128415
git_version=1.8.5.3

echo "Downloading git-$git_version"
cd /usr/local/src
wget -O git-v$git_version.tar.gz https://github.com/git/git/archive/v$git_version.tar.gz
tar -xzvf ./git-v$git_version.tar.gz

echo "Compiling git-$git_version"
cd git-$git_version/
make prefix=/usr/local all
make prefix=/usr/local install

echo "Cleaning up"
cd /usr/local/src
rm -rf ./git-v$git_version.tar.gz git-$git_version
