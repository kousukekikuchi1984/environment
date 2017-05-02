# Kosuke Kikuchi's Development Environment

## requirement
* homebrew

# installation
## install homebrew
```
$ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install brew from local file
$ cat brewlist.txt | xargs -I{} brew install {}
$ cat casklist.txt | xargs -I{} brew cask install {}
``` 

## setup zshell
```
$ git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

$ setopt EXTENDED_GLOB
$ for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
$   ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
$ done

# set zsh as default shell
$ sudo chsh -s /bin/zsh

$ cp zshrc ~/.zshrc
$ cp zpreztorc ~/.zpreztorc
``` 

## jshint activation
```
$ node install -g jshint
$ cp jshintrc ~/.jshintrc
```

## nvim setup
``` 
$ curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
$ sh ./installer.sh ~/.local/share/dein
$ cp init.vim ~/.config/nvim/init.vim

# open vim and command
:call dein#install()
```


