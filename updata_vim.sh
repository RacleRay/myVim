#!/bin/bash


echo ""
echo "开始安装Vim 8.2"
if which apt-get >/dev/null; then
    sudo add-apt-repository ppa:jonathonf/vim
    sudo apt-get update
	sudo apt-get install -y vim vim-gnome ctags xclip astyle python-setuptools python-dev python3-pip git wget
elif which yum >/dev/null; then
	sudo yum install -y gcc vim git ctags xclip astyle python-setuptools python-devel python3-pip wget	
fi

##Add HomeBrew support on  Mac OS
if which brew >/dev/null;then
    echo "You are using HomeBrew tool"
    brew install vim ctags git astyle
fi
echo "完成安装Vim 8.2"
