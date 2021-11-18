#!/bin/bash

installer="sudo apt install"

echo "set up the command line environment\n"
`$installer curl wget zsh`
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
sh -c "$(curl -fsSL https://starship.rs/install.sh)"

echo "install neovim\n"
brew install neovim --HEAD
# `$installer ninja-build gettext libtool libtool-bin autoconf automake \
# 	cmake g++ pkg-config unzip doxygen`
# git clone https://github.com/neovim/neovim.git
# cd neovim
# git checkout stable
# make CMAKE_BUILD_TYPE=Release
# sudo cp ./build/bin/nvim /usr/local/nvim
# cd $HOME
# sudo rm -r neovim

echo "install tmux\n"
`$installer tmux -y`

echo "install rust and rust packages\n"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
cargo install bat git-delta du-dust exa fd-find ripgrep sd

echo "install go and go packages\n"
wget https://dl.google.com/go/go1.17.2.linux-amd64.tar.gz
sudo tar -C /usr/local/ -xzf go1.17.2.linux-amd64.tar.gz
go get github.com/prasmusen/gdrive
go get fzf

echo "install alacritty\n"
`$installer cmake pkg-config libfreetype6-dev libfontconfig1-dev \
	libxcb-xfixes0-dev libxkbcommon-dev python3`
git clone https://github.com/alacritty/alacritty.git
cd alacritty
cargo build --release
sudo tic -xe alacritty,alacritty-direct extra/alacritty.info
sudo cp target/release/alacritty /usr/local/bin # or anywhere else in $PATH
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database
cd $HOME

echo "install discord\n"
download_link=`curl "https://discord.com/api/download?platform=linux&format=tar.gz" \
	| rg 'https://.*?.gz' -o | head -n 1`
curl $download_link | sudo tar -xvzf discord* -C /opt
sudo ln -sf /opt/Discord/Discord /usr/bin/Discord
sudo cp -r /opt/Discord/discord.desktop /usr/share/applications

