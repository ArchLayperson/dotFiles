#!/bin/sh
scriptFile=$(readlink -f "$0")
scriptDir=$(dirname "$scriptFile")
ln -s $scriptDir/.zshrc $HOME/.zshrc
