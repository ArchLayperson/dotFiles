
setopt autocd beep extendedglob nomatch
unsetopt appendhistory notify
bindkey -v

HOST_NAME=$(hostname)
if [ "$HOSTNAME" = "virtubsd" ] ||
   [ "$HOSTNAME" = "virtuosx" ]; then
	alias xl="echo Try that on the HOST, this is a VM!"
fi

alias la="ls -a"
alias ll="ls -all"
alias lg="ls -all |grep"

if which ruby >/dev/null 2>&1; then
    export PATH=$(ruby -rubygems -e "puts Gem.user_dir")/bin:$PATH
fi


if which vim >/dev/null 2>&1; then
    EDITOR=vim
    VISUAL=vim
    export EDITOR
    export VISUAL
fi

