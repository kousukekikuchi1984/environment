#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

if [ -d /opt/local ]; then

export PORTS_HOME=/opt/local
export PATH=$PORTS_HOME/bin:$PORTS_HOME/sbin:$PATH
export MANPATH=$PORTS_HOME/man:$MANPATH
export DISPLAY=:0.0

# C のヘッダファイルを探す場所
export C_INCLUDE_PATH=$PORTS_HOME/include:/usr/include:/usr/local/include:/opt/local/include:$PYTHON_FRAMEWORK/Headers:$C_INCLUDE_PATH
          #
# C++ のヘッダファイルを探す場所
export CPLUS_INCLUDE_PATH=$PORTS_HOME/include:/usr/include:/usr/local/include:/opt/local/include:$PYTHON_FRAMEWORK/Headers:$CPLUS_INCLUDE_PATH
export LIBRARY_PATH=.:$PORTS_HOME/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=/opt/local/lib:$LD_LIBRARY_PATH
# ランタイムライブラリの場所 (man dyld)
#     By default, it is set to $(HOME)/lib:/usr/local/lib:/lib:/usr/lib.
# MacPorts のために DYLD_LIBRARY_PATH を使ってはいけない理由
#     http://apribase.net/2010/11/13/macports-dyld_library_path/
 export DYLD_FALLBACK_LIBRARY_PATH=.:$PORTS_HOME/lib:$DYLD_FALLBACK_LIBRARY_PATH

# フレームワークの場所 (man dyld)
#     By default, it is set to /Library/Frameworks:/Network/Library/Frameworks:/System/Library/Frameworks
DYLD_FALLBACK_FRAMEWORK_PATH=$PORTS_HOME/Library/Frameworks:$DYLD_FALLBACK_FRAMEWORK_PATH

export PYTHONPATH=.:$PORTS_HOME/lib/python2.7/site-packages:$PORTS_HOME/Library/Frameworks/Python.framework/Versions/Current/lib/python2.7/site-packages:$PYTHONPATH
fi

autoload -U compinit
compinit
setopt correct
zstyle ':completion:*' list-colors ${(s.:.)LSCOLORS}

zstyle :compinstall filename '/Users/kousukekikuchi/.zshrc'
autoload -Uz compinit
compinit
HISTSIZE=100000
SAVEHIST=100000
# Customize to your needs...
HISTFILE=~/.histfile
bindkey -v

if [ $UID = 0 ]; then
    unset HISTFILE
    SAVEHIST=0
fi

setopt hist_ignore_dups # never save the same history

# Search backwards and forwards with a pattern
bindkey -M vicmd '/' history-incremental-pattern-search-backward
bindkey -M vicmd '?' history-incremental-pattern-search-forward

# set up for insert mode too
bindkey -M viins '^R' history-incremental-pattern-search-backward
bindkey -M viins '^F' history-incremental-pattern-search-forward
export LANG=ja_JP.UTF-8
export LANGUAGE=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export LSCOLORS=gxfxcxdxbxegedabagacad
#zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'
