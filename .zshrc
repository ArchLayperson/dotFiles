HOST_NAME=$(hostname)
if [ "$HOSTNAME" = "virtubsd" ] ||
   [ "$HOSTNAME" = "virtuosx" ]; then
	alias xl="echo Try that on the HOST, this is a VM!"
fi

alias la="ls -a"
alias ll="ls -all"
alias lg="ls -all |grep"

