#!/bin/sh

cd ~/.vim
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
ln -s ~/.vim/.vimrc ~/
mkdir -p ~/.fonts
cp ~/.vim/fonts/DroidSansMono.ttf ~/.fonts
fc-cache -vf
vim +BundleInstall! +q

if man pacman > /dev/null; then # verify if is Arch Linux
    cd ~/.vim/bundle/YouCompleteMe
    sudo pacman -S cmake ctags # dependences for YCM
    ./install.sh --clang-completer  # compile YCM
else
    echo "Sorry, this installer not support your distro!"
    echo "Please configure YouCompleteMe and ctags for your machine!"
fi
