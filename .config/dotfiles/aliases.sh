#!/usr/bin/env bash

# single letter
alias d='dots'
alias g='git'
alias l='ls'
alias o='open'
alias t='trash'
alias z='source $HOME/.zshrc'
alias e="$EDITOR"

# dotfiles
alias dots='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# python
alias py='python3'

# git
alias ga='git add'
alias gb='git branch'
alias gbd='gb -d'
alias gbD='gb -D'
alias gc='git commit'
alias gcm='gc -m'
alias gca='gc --amend'
alias gcan='gca --no-edit'
alias gch='git checkout'
alias gchb='gch -b'
alias gcp='git cherry-pick'
alias gd='git diff'
alias gds='git diff --staged'
alias gf='git fetch'
alias gl='git log --decorate --oneline --graph'
alias gla='gl --all'
alias glas='gla --simplify-by-decoration'
alias gl20='gl -20'
alias gla20='gla -20'
alias gps='git push'
alias gpl='git pull'
alias gf='git fetch'
alias gr='git rebase'
alias gra='gr --abort'
alias grc='gr --continue'
alias grs='gr --skip'
alias grom='gr master'
alias grim='gr -i master'
alias gs='git status'
alias gsh='git show'

# List files
alias ls='ls --color=auto -h'
alias la='ls -la'
alias latr='ls -latr'

# Find files
alias fd='find . -type d -name'
alias ff='find . -type f -name'

# Utils
alias svim='sudo vim'
alias please='sudo'

# Guard against fuckups. Ask before overwriting or removing
alias cp='cp -i'
alias rm='rm -i'

# Shortcut for grepping
alias grep="grep --color=auto"
alias G='| grep'

# ROS shortcuts
alias tftree='cd /var/tmp && rosrun tf2_tools view_frames.py && cd - && open /var/tmp/frames.pdf &'
alias tfecho='rosrun tf tf_echo'

# Shortcuts
alias cd..="cd .."
alias gd="cd ~/Downloads"
alias gob="cd ~/dev/baktus"
alias goc="cd ~/dev/motion_planning"

# Play a complete
alias playcomplete='paplay /usr/share/sounds/freedesktop/stereo/bell.oga'

# Shortcuts to dev containers
alias crt='cd ~/dev/kinova; mikkel --base-image jorgenfb/ros-dev:melodic --env-file .devcontainer/.env'
alias baktus='cd ~/dev/baktus; mikkel --base-image jorgenfb/ros-dev:kinetic --env-file .devcontainer/.env'

# Quickly jump into a project
alias goproject='cd $(find ~/dev -maxdepth 1 -type d | fzf)'

# Password helpers
alias opsession='eval $(op signin team_nlink)'
alias opjaibot="op item get bzhol57rzfuvpwodrgxtwsqcaa --field label=password | xclip -selection clipboard"
alias oprockethouse="op item get ebvlw3vsq44rpl5sfn4er46ici --field label=password | xclip -selection clipboard"

# Start chrome with a local proxy
alias proxychromium='chromium --proxy-server="http://localhost:3128" & disown'
