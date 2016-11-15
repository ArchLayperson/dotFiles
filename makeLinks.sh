#!/bin/bash
scriptFile=$(readlink -f "$0")
scriptDir=$(dirname "$scriptFile")
for dotFile in $(ls -A ${scriptDir}/dotFiles); do
	filename=$(basename ${dotFile})
        if [ -e ${HOME%/}/${filename} ]; then
            echo "Removeing old ${filename}"
            unlink ${HOME%/}/${filename}
        fi
	echo "Linking ${HOME%/}/${filename} to ${scriptDir}/dotFiles/${dotFile}"
	ln -s ${scriptDir}/dotFiles/${dotFile} ${HOME%/}/${filename}
done


