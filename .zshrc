# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

export PATH="/usr/local/bin:usr/local:/usr/local/heroku/bin:\
            /usr/local/share/npm/bin:/usr/bin:/bin:/usr/sbin:\
            /sbin:/usr/local/Cellar/ruby/2.0.0-p247/bin:\
            /usr/local/CrossPack-AVR/bin:/sbin"
# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="remy"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment following line if you want to  shown in the command execution time stamp
# in the history command output. The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|
# yyyy-mm-dd
# HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git vi-mode zsh-history-substring-search fasd)
# eval "$(fasd --init auto)"
export EDITOR='vim'
# http://superuser.com/questions/306028/tmux-and-zsh-custom-prompt-bug-with-window-name
DISABLE_AUTO_TITLE=true
source $ZSH/oh-my-zsh.sh
# ovverride the default history completion with this really cool one
# source $ZSH/.history-completion-for-zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
# source $ZSH/.history-completion-for-zsh/zsh-history-substring-search/zsh-history-substring-search.plugin.zsh
# map this to do some coof stuff in
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
# source $ZSH/.history-completion-for-zsh/zsh-history-substring-search/zsh-history-substring-search.zsh
source $ZSH/zsh-autosuggestions/autosuggestions.zsh
# source completion for tmuxinator
source ~/.tmuxinator/tmuxinator.zsh

AUTOSUGGESTION_HIGHLIGHT_COLOR='fg=242'
zle-line-init() {
    zle autosuggest-start
}
zle -N zle-line-init
# bind the key for the completion
bindkey '^f' vi-forward-blank-word
bindkey '^e' end-of-line
# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# # Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
# NVM
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

######################################################################
# custom modifications

# source custom functions
source $ZSH/githubCreate.sh

alias denv="workon dxm && cd ~/Documents/dxm"
alias gudenv="workon gudenv && cd ~/Documents/gudli"
alias gst="git status"
alias glo="git log"
alias gco="git checkout"
alias gbr="git branch"
alias ls="ls -aF -G"
alias gpu="git pull"
alias gdf="git diff"
alias gph="git push -u"
alias lsd="ls -d"
alias gclean="git clean -df"
alias githubCreate=githubCreate
# this is in case of error of opening macvim
# http://stackoverflow.com/questions/17537871/macvim-failed-to-start-after-connecting-to-a-extra-display-and-disconnected
alias clearvim='rm -r ~/Library/Preferences/*.vim.*'

# tell the virtualenv to lay off prompt
VIRTUAL_ENV_DISABLE_PROMPT=true
# set where virutal environments will live
export WORKON_HOME=$HOME/.virtualenvs
# ensure all new environments are isolated from the site-packages directory
export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
# use the same directory for virtualenvs as virtualenvwrapper
export PIP_VIRTUALENV_BASE=$WORKON_HOME
# makes pip detect an active virtualenv and install to it
export PIP_RESPECT_VIRTUALENV=true
if [[ -r /usr/local/bin/virtualenvwrapper.sh ]]; then
    source /usr/local/bin/virtualenvwrapper.sh
else
    echo "WARNING: Can't find virtualenvwrapper.sh"
fi

#this line is for the macvim to funtion properly Don't remove it
export DYLD_FORCE_FLAT_NAMESPACE=1

# this is used for refreshing tmux status bar on every command
# this is a zsh command and runs before every zsh command
if [[ -n $TMUX ]]; then
    precmd() {
        tmux refresh-client -S
    }
fi


# this lets you view man pages in vim NOT KIDDING
export MANPAGER="/bin/sh -c \"unset MANPAGER;col -b -x | \
    vim --cmd 'let g:plugins=2' --noplugin -R -c 'set ft=man nomod nolist' -c 'map q :q<CR>' \
    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' \
    -c 'set laststatus=0' -c 'set nonumber' \
    -c 'set nocursorcolumn' -c 'set nocursorline' \
    -c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\""


# inserting some of the cool custom functions
setopt correct
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# FZF functions
__gsel(){
  command git branch -r\
    2> /dev/null | sed 1d | cut -b3- | $(__fzfcmd) -m | while read item; do
    printf '%q ' "$item"
  done
  echo
}

fzf-git-widget() {
  LBUFFER="${LBUFFER}$(__gsel)"
  zle redisplay
}
zle     -N   fzf-git-widget
bindkey '^g' fzf-git-widget

