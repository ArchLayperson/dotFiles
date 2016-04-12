#!/bin/sh
scriptFile=$(readlink -f "$0")
scriptDir=$(dirname "$scriptFile")

git --work-tree=$scriptDir fetch
git --work-tree=$scriptDir reset --hard origin/master

