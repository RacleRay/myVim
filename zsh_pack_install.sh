#!/bin/sh

echo ">>> Installing zsh-syntax-highlighting ..."
git clone https://gitee.com/suyelu/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

mv ~/.zshrc ~/.zshrc_backup
sed 's/plugins=(git)/plugins=(git zsh-syntax-highlighting)/' ~/.zshrc_backup > ~/.zshrc
echo ">>> Success."

#echo ">>> Installing incr ..."
#mkdir ~/.oh-my-zsh/plugins/incr 2>/dev/null
#cp ./incr-0.2.zsh ~/.oh-my-zsh/plugins/incr/incr.plugin.zsh
#echo ">>> Success."

echo ">>> Installing autojump ..."
sudo apt install -y autojump >/dev/null 2>&1
echo ">>> Success."

echo ">>> Config zshrc ..."
cat>>~/.zshrc<<EOF
alias cl=clear
alias python=/usr/bin/python3
#source ~/.oh-my-zsh/plugins/incr/incr*.zsh
EOF
echo ">>> Success."

echo ">>> Ended. Please restart your shell"
