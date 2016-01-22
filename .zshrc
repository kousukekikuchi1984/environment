# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=100000000
SAVEHIST=100000000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/Users/kikuchikousuke/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

export LANG=ja_JP.UTF-8
export LANGUAGE=UTF-8
export LC_ALL=ja.JP.UTF-8

autoload colors
export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
alias ls="ls -GF"
alias gls="gls --color"

zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'


autoload -Uz vcs_info
setopt prompt_subst

zstyle ':vcs_info:*' formats '%s][* %F{green}%b%f'
zstyle ':vcs_info:*' actionformats '%s][* %F{green}%b%f(%F{red}%a%f)'
precmd() { vcs_info }
PROMPT='[${vcs_info_msg_0_}]:%~/%f '

export DOCKER_TLS_VERIFY="1"
export DOCKER_HOST="tcp://192.168.99.100:2376"
export DOCKER_CERT_PATH="/Users/kikuchikousuke/.docker/machine/machines/default"
export DOCKER_MACHINE_NAME="default"

export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export LC_ALL=ja_JP.UTF-8

export LSCOLORS=gxfxcxdxbxegedabagacad
export MANPATH=/opt/local/share/man:$MANPATH
export DISPLAY=:0.0

export PATH=/usr/local/cuda/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib:$LD_LIBRARY_PATH
