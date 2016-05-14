
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

if which vim >/dev/null; then
    EDITOR=vim
    VISUAL=vim
    export EDITOR
    export VISUAL
fi

