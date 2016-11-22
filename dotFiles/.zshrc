
export HISTFILE=${HOME}/.zhistory
export HISTSIZE=200
export SAVEHIST=1000

setopt autocd autopushd pushdsilent pushdtohome beep extendedglob nomatch appendhistory correct checkjobs autolist histignoredups histignorespace
unsetopt notify
bindkey -v

HOST_NAME=$(hostname)
if [ "$HOSTNAME" = "virtubsd" ] ||
   [ "$HOSTNAME" = "virtuosx" ]; then
	alias xl="echo Try that on the HOST, this is a VM!"
fi

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

source ~/.zshprompt
