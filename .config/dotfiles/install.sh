#!/usr/bin/env bash

set -e
shopt -s expand_aliases

#
# Add system repositories
#
sudo add-apt-repository ppa:peek-developers/stable -y

# Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Microsoft vscode
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg

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
    code \
	containerd.io \
    curl \
	diodon \
	docker-ce \
    docker-ce-cli \
    ffmpeg \
    gdb \
    git \
    git-lfs \
    htop \
    jq \
    minicom \
    nmap \
    python3-pip \
    shellcheck \
    silversearcher-ag \
    snapd \
    tldr \
    trash-cli \
    tree \
    vim \
    virtualbox \
    wget \
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
