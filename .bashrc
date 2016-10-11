#/bin/bash

exec 3<.aliases
        read aliasname aliasvalue <&3 #
        echo "Aliasing ${aliasname} to ${aliasvalue}"
        alias ${aliasname}="${aliasvalue}"
        unset aliasname
        unset aliasvalue
exec 3<&-

source .bashprompt
