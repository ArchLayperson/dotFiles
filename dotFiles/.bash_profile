#/bin/bash

exec 3<.aliases
	while true; do
        read aliasname aliasvalue <&3 #
	if [ ! -n "${aliasname}" ]; then
		break
	fi
        alias ${aliasname}="${aliasvalue}"
        unset aliasname
        unset aliasvalue
	done
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

if which dircolors 2>&- >&-; then
    eval $(dircolors .dircolors)
fi

source .bashprompt
