#/bin/bash

exec 3<.aliases
        read aliasname aliasvalue <&3 #
        alias ${aliasname}="${aliasvalue}"
        unset aliasname
        unset aliasvalue
exec 3<&-

if which less 2>&- >&-; then
	export PAGER=less
fi

if which vim 2>&- >&-; then
    EDITOR=vim
    VISUAL=vim
    export EDITOR
    export VISUAL
fi

if which ruby 2>&- >&-; then
    export PATH=$(ruby -rubygems -e "puts Gem.user_dir")/bin:$PATH
fi

source .bashprompt
