#!/usr/bin/env bash

set -e
shopt -s expand_aliases

#
# Add system repositories
#

# Install system packages
sudo apt-get update -qq
sudo apt-get upgrade -qq
sudo apt-get install -qq \
    apt-transport-https \
    build-essential \
    bpython \
    clang \
    clang-format \
    clang-tidy \
    cloc \
    cmake \
    cmake-curses-gui \
    containerd.io \
    curl \
    diodon \
    ffmpeg \
    gdb \
    git \
    git-lfs \
    htop \
    jq \
    minicom \
    nmap \
    python3-pip \
    ranger \
    rar \
    rofi \
    shellcheck \
    silversearcher-ag \
    snapd \
    terminator \
    tldr \
    trash-cli \
    tree \
    vim \
    virtualbox \
    wget \
    wmctrl \
    xclip \
    zsh

# Install Python packages
pip3 install -q \
    black \
    cmakelang \
    gita \
    thefuck \
    vcstool

# Install snaps
sudo snap install blender  --classic
sudo snap install slack  --classic

# Setup ccache
sudo /usr/sbin/update-ccache-symlinks

# Setup git-lfs
git-lfs install

# Install FZF
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --key-bindings --completion --no-update-rc

# Setup ZSH with oh-my-zsh and themes/plugins
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
chsh -s "$(command -v zsh)"
ZSH_CUSTOM=~/.oh-my-zsh/custom
wget -q -O "$ZSH_CUSTOM/themes/bullet-train.zsh-theme" https://raw.githubusercontent.com/caiogondim/bullet-train.zsh/master/bullet-train.zsh-theme
git clone -q https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
git clone -q https://github.com/chrissicool/zsh-256color.git "$ZSH_CUSTOM/plugins/zsh-256color"
git clone -q https://github.com/powerline/fonts.git --depth=1 /tmp/fonts && /tmp/fonts/install.sh

# Clone dotfiles
grep -sqxF ".dotfiles" ~/.gitignore || echo ".dotfiles" >> ~/.gitignore
git clone -q --bare git@github.com:jorgenfb/dotfiles.git ~/.dotfiles
alias dots='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dots checkout --force
dots config --local status.showUntrackedFiles no
dots config --local --add remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
dots fetch

# Configure OS
~/.config/dotfiles/dconf/doit.sh load

echo "Done! Log out and back in again."
