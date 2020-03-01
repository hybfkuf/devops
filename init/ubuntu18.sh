#!/bin/bash
# Author: hybfkuf
# Description:
#   update && upgrade ubuntu
#   vim
#   tmux

EXIT_SUCCESS=0
EXIT_FAILURE=1
SUCCESS_COUNT=0
HOME="/root"
DEBIAN_FRONTEND=noninteractive

RED='\E[1;31m'
GREEN='\E[1;32m'
YELLOW='\E[1;33m'
BLUE='\E[1;34m'
PINK='\E[1;35m'
RES='\E[0m'
#echo -e "${RED}Hello Shell${RES}"
#echo -e "${GREEN}Hello Shell${RES}"
#echo -e "${BLUE}Hello Shell${RES}"
#echo -e "${PINK}Hello Shell${RES}"

check_exit_status() {
    if [ $? -eq 0 ]; then
        SUCCESS_COUNT=$(($SUCCESS_COUNT + 1))
        echo
        echo -e "${GREEN}Successful $SUCCESS_COUNT ${RES}"
        echo
    else
        echo
        echo "[ERROR] Process Failed"
        exit $EXIT_FAILURE
    fi
}

check_root() {
    if [ ! $(id) -eq 0 ]; then
        echo -e "${RED}you must be root${RES}"
        exit $EXIT_FAILURE
    fi
}

check_update() {
    apt-get update
    apt-get upgrade --yes 
    apt-get dist-upgrade --yes 
    apt-get autoremove --yes 
    apt-get autoclean --yes
    updatedb

}




# =============== start ===============

check_root
check_update

# configure vim tmux
apt-get install -y git vim build-essential cmake python3-dev tmux fish
[ -e "$HOME/.tmux.conf" ] && rm -rf "$HOME/.tmux.conf"
[ -e "/tmp/init" ] && rm -rf /tmp/init/
[ -e "$HOME/.vimrc" ] && rm -rf "$HOME/.vimrc"
[ -e "$HOME/.vim/" ] && rm -rf "$HOME/.vim"
cp /tmp/init/tmux.conf "$HOME/.tmux.conf"
git clone https://github.com/hybfkuf/init /tmp/init
cp /tmp/init/vimrc "$HOME/.vimrc"
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim "$HOME/.vim/bundle/Vundle.vim"
vim +PluginInstall +qall
echo "colorscheme yowish" >> "$HOME/.vimrc"
# compile YouCompleteMe
cd "$HOME/.vim/bundle/YouCompleteMe"
#python3 install.py --clang-completer
bash install.sh

# configure oh-my-fish
[ -e "/tmp/oh-my-fish" ] && rm -rf /tmp/oh-my-fish
[ -e "$HOME/.conf/omf" ] && rm -rf "$HOME/.conf/omf"
[ -e "$HOME/.local/share/omf" ] && rm -rf "$HOME/.local/share/omf"
git clone https://github.com/oh-my-fish/oh-my-fish /tmp/oh-my-fish/
/tmp/oh-my-fish/bin/install --offline
omf install random
chsh /usr/bin/fish
