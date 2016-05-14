#!/bin/sh
scriptFile=$(readlink -f "$0")
scriptDir=$(dirname "$scriptFile")
ln -s $scriptDir/.zshrc $HOME/.zshrc
ln -s $scriptDir/.vimrc $HOME/.vimrc
ln -s $scriptDir/.xkeybindrc $HOME/.xkeybindrc


