DOTFILES="${HOME}/.config/dotfiles"

function source_if_found { [[ -f "$1" ]] && source "$1"; }

############################################################
# environment                                              #
############################################################

source "${DOTFILES}/env-shared.sh"
source_if_found "${DOTFILES}/env-machine-specific.sh"

############################################################
# shell                                                    #
############################################################

ZSH_THEME="bullet-train"
BULLETTRAIN_STATUS_EXIT_SHOW=true
BULLETTRAIN_EXEC_TIME_ELAPSED=1
BULLETTRAIN_PROMPT_CHAR=
BULLETTRAIN_PROMPT_SEPARATE_LINE=false
BULLETTRAIN_PROMPT_ADD_NEWLINE=false
BULLETTRAIN_PROMPT_ORDER=(status custom dir git hg cmd_exec_time)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=2"  # Green autosuggestion text.

# I have systems that does not support thefuck command
if [[ -z thefuck ]]; then
	plugins=(gitfast thefuck zsh-autosuggestions zsh-256color)
else
	plugins=(gitfast zsh-autosuggestions zsh-256color)
fi



source "$ZSH/oh-my-zsh.sh"

setopt nonomatch

HISTFILE=~/.histfile
HISTSIZE=1000000
SAVEHIST=1000000

setopt autocd
setopt correct
setopt extendedhistory
setopt completeinword
setopt completealiases

setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.


############################################################
# load stuff                                               #
############################################################

source "$DOTFILES"/functions.sh
source "$DOTFILES"/aliases.sh
source_if_found "$DOTFILES"/machine-specific.sh

# Superb fuzzy search for command history and tab completion
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

############################################
# Local command history for arrow up
############################################
bindkey "${key[Up]}" up-line-or-local-history
bindkey "${key[Down]}" down-line-or-local-history

up-line-or-local-history() {
    zle set-local-history 1
    zle up-line-or-history
    zle set-local-history 0
}
zle -N up-line-or-local-history
down-line-or-local-history() {
    zle set-local-history 1
    zle down-line-or-history
    zle set-local-history 0
}
zle -N down-line-or-local-history


source /home/jorgen/.config/broot/launcher/bash/br

