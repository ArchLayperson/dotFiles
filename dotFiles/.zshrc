

# locate this script, and it's buddies, zsh sets $0 when sourcing but not at start-time
if [ "x$0" = "x$ZSH_NAME" ]; then
	# Invoked as part of ZSH's startup, so dir is HOME
	ABH_PROFILE_DIR="$HOME"
else
	# Otherwise we were started from a source command
	THIS_SCRIPT="$0:a"
	ABH_PROFILE_DIR="$(dirname "$THIS_SCRIPT")"
fi
export ABH_PROFILE_DIR


export HISTFILE=${ABH_PROFILE_DIR}/.zhistory
export HISTSIZE=200
export SAVEHIST=1000

setopt autocd autopushd pushdsilent pushdtohome beep extendedglob nomatch appendhistory correct checkjobs autolist histignoredups histignorespace
unsetopt notify
bindkey -v

if [ "$HOSTNAME" = "virtubsd" ] ||
   [ "$HOSTNAME" = "virtuosx" ]; then
	alias xl="echo Try that on the HOST, this is a VM!"
fi

exec 3< ${ABH_PROFILE_DIR}/.aliases
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

# In ZSH, which is a builtin, so it does not need special handling on Solaris

if which ruby >/dev/null 2>&1; then
    export PATH=$(ruby -rubygems -e "puts Gem.user_dir")/bin:$PATH
fi

if which less >/dev/null 2>&1; then
    export PAGER=less
fi

if which vim >/dev/null 2>&1; then
    EDITOR=vim
    VISUAL=vim
    export EDITOR
    export VISUAL
fi

if which dircolors 2>&- >&-; then
    eval $(dircolors .dircolors)
fi

if [ "x$(uname)" = "xSunOS" ]; then
	alias godmode='su abhroot -c "${SHELL} -i"'
fi

source ${ABH_PROFILE_DIR}/.zshprompt

if [ "$(id -urn)" = "jxstory" ] || [ "$SUDO_USER" = "jxstory" ]; then
	RPROMPT="%B%K{red}%F{black} Damnit Jody %K{reset}%F{reset}%b"
	echo -n "Making Jody contemplate his life choices"
	for i in $(seq 1 5); do
		sleep 2
		echo -n "."
	done
	echo ""
fi
