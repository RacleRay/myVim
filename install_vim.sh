#!/bin/bash
echo "============================================="
echo "This script will install and configure vim and zsh automatic."
echo "The time this takes is related to the network conditions, please wait patiently."
if [[ `whoami` == "root" ]];then
    echo -e "\033[31mYou are  running this script with Root\033[0m"
    echo -e "\033[31mGenerally, we do not recommend using root for programming or directly controlling your Linux OS, especially when you are a beginner \033[0m"
    echo -e "\033[31mSo, There is no necessary for you to configure with root."
    read -p "Do you really want to do this?[N/y]" choice
    if [[ ${choice} != y ]];then
    	echo "Bye."
    	exit 1
    fi
fi
echo "============================================="

echo ""
echo "开始安装Vim 8.2"
if which apt-get >/dev/null; then
    sudo add-apt-repository ppa:jonathonf/vim
    sudo apt-get update
	sudo apt-get install -y vim vim-gnome ctags xclip astyle python-setuptools python-dev git wget
elif which yum >/dev/null; then
	sudo yum install -y gcc vim git ctags xclip astyle python-setuptools python-devel wget	
fi

##Add HomeBrew support on  Mac OS
if which brew >/dev/null;then
    echo "You are using HomeBrew tool"
    brew install vim ctags git astyle
fi
echo "完成安装Vim 8.2"



# clone repository
echo ""
echo "开始加载文件"
cd ~/
git clone https://gitee.com/racleray/vim.git 2>/dev/null

mv -f ~/.vim ~/.vim_old 2>&1 >/dev/null
mv -f ~/vim ~/.vim 2>&1 >/dev/null
mv -f ~/.vimrc ~/.vimrc_old 2>&1 >/dev/null
mv -f ~/.vim/.vimrc ~/ 
mv -f ~/.vim/.clang-format ~/ 
mv -f ~/.vim/.config/coc ~/.config/
sudo chmod 755 ~/.config/coc/extensions/coc-clangd-data/install/13.0.0/bin/clangd

echo ""
echo "解压文件"
cd ~/.vim/bundle/
unzip -q bundle.zip -d ~/.vim/bundle/
cd ~/

echo ""
echo "VIM插件安装"
echo "程序正在自动安装相应插件" > install_info
echo "command-t插件需要等待时间较长" >> install_info
echo "=====================================：" >> install_info
echo "  经过多次测试，command-t插件最后可能会报错，但是实际上却安装上了；" >> install_info
echo "  你可以在安装完成后，执行\`vim\`命令，并直接输入:BundleInstall,回车，来重新开始安装。" >> install_info
echo "  如果真的没有安装成功，会重新安装未完成的插件。" >> install_info
echo "安装完毕将自动退出" >> install_info

vim install_info -c "BundleInstall" -c "q" -c "q"
rm install_info
echo "安装完成"

echo ""
echo "安装环境工具"
sudo apt install -y clang-format 
sudo pip3 install jedi-language-server python-lsp-server[all] autopep8 flake8
echo "安装完成，python配置需要在使用的python环境中安装对应的包"

echo ""
echo "安装nodejs"
wget https://npmmirror.com/mirrors/node/v16.14.0/node-v16.14.0-linux-x64.tar.xz
sudo mkdir -p /usr/nodejs/
sudo tar xf node-v16.14.0-linux-x64.tar.xz --directory=/usr/
sudo mv /usr/node-v16.14.0-linux-x64/ /usr/nodejs/
sudo rm -f /usr/bin/npm 2>/dev/null
sudo rm -f /usr/bin/node 2>/dev/null
sudo ln -s /usr/nodejs/bin/npm /usr/bin/
sudo ln -s /usr/nodejs/bin/node /usr/bin/
rm node-v16.14.0-linux-x64.tar.xz
echo "安装完成"

echo ""
echo "Build coc"
sudo npm install -g yarn
export PATH=/usr/nodejs/bin/:$PATH
cd ~/.vim/bundle/coc.nvim/
yarn install
yarn build
cd ~/
echo "build successfully"

echo ""
echo "配置ctags"
sudo apt install -y glibc-doc
sudo ln -s /usr/bin/ctags /usr/local/bin/ctags
ctags -I __THROW -I __attribute_pure__ -I __nonnull -I __attribute__ --file-scope=yes --langmap=c:+.h --languages=c,c++ --links=yes --c-kinds=+p --c++-kinds=+p --fields=+iaS --extra=+q  -f ~/.vim/systags /usr/include/* /usr/include/x86_64-linux-gnu/sys/* /usr/include/x86_64-linux-gnu/bits/*  /usr/include/arpa/*
sudo apt install -y glibc-doc
cat>>~/.vimrc<<EOF
set tags+=~/.vim/systags
EOF
echo "配置完成"

echo ""
echo "配置pydocstring"
sudo apt install -y python3-venv
python3 -m venv ~/.config/coc/extensions/coc-pydocstring-data/doq/venv
~/.config/coc/extensions/coc-pydocstring-data/doq/venv/bin/python -m pip install -U pip wheel
~/.config/coc/extensions/coc-pydocstring-data/doq/venv/bin/python -m pip install -U doq==0.9.1
echo "配置完成"
echo "安装完成，python配置需要在使用的python环境中安装对应的包"


rm -rf ~/vim 2>&1 >/dev/null
rm -rf ~/.vim_old 2>&1 >/dev/null