#!/usr/bin/env bash

export ZSH=$HOME/.oh-my-zsh

# shellcheck disable=SC2016
export ROSCONSOLE_FORMAT='[${severity}] [${node}] [${time}]: ${message}'

####################################################################################
# Install npm packages globally without sudo
#
# https://github.com/sindresorhus/guides/blob/master/npm-global-without-sudo.md
####################################################################################
NPM_PACKAGES="${HOME}/.npm-packages"
PATH="$NPM_PACKAGES/bin:$PATH"

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH # delete if you already modified MANPATH elsewhere in your config
export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

#############################################
# Set default editor
#############################################
export VISUAL=vim
export EDITOR="$VISUAL"

#############################################
# Setup for developing BAKTUS
#############################################
export NLINK_COMPILE_LEVEL=superstrict

if (( ${+EXTRA_SOURCE} )); then
  # Used inside dev container to autosource
  source "/opt/ros/$ROS_DISTRO/setup.zsh"
  source $EXTRA_SOURCE
fi

#############################################
# Add AppImage folder
#############################################
PATH="${HOME}/apps:$PATH"
