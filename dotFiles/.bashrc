#/bin/bash

# This gets source'd by either bash_profile or bash itself upon startup
THIS_SCRIPT="$BASH_SOURCE"

ABH_PROFILE_DIR="$(dirname $THIS_SCRIPT)"
export ABH_PROFILE_DIR

# A function to ditermine if an executable exists in the current path, as solaris which does not have a return code

function haveBinary() {
	[ -x "$(which $1 2>/dev/null)" ]
	return $?
}

# If ZSH is available, i'd much rather have that, so if it is there, jump, but give a chanse to cancel
# logically, this should be in profile, but I would have to duplicate haveBinary there if I did..
if shopt -q login_shell && haveBinary zsh; then	

	SWAP_TO_ZSH=1

	function noredir () {
		SWAP_TO_ZSH=0
	}

	trap noredir INT
	echo -n "Redirecting to ZSH. Press ^C to cancel..."
	sleep 2
	trap - INT
	if [ "x$SWAP_TO_ZSH" == "x1" ]; then 
		echo " Launching ZSH!"
		export SHELL=$(which zsh)
		exec zsh
	fi
	# If we are still executing at this point, we are still in bash
	echo " Redirect Aborted!"

fi

exec 3<$ABH_PROFILE_DIR/.aliases
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

if haveBinary less; then
	export PAGER=less
fi

if haveBinary vim; then
    EDITOR=vim
    VISUAL=vim
    export EDITOR
    export VISUAL
fi

if haveBinary ruby; then
    export PATH=$(ruby -rubygems -e "puts Gem.user_dir")/bin:$PATH
fi

if haveBinary dircolors; then
    eval $(dircolors .dircolors)
fi

source $ABH_PROFILE_DIR/.bashprompt
