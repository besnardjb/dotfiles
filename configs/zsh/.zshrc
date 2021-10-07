# ZSH config
#
#

zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle :compinstall filename '/home/jbbesnard/.zshrc'
autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000000000
SAVEHIST=100000000
setopt appendhistory autocd extendedglob notify
unsetopt beep nomatch
bindkey -e

##### CONF VARS ####
#
#

RCDEBUG=0

debugrc()
{
	if "${RCDEBUG}" = "0"; then
		return 0
	fi

	echo "$@"
}




# Some Helper functions
#
#

# RECURSIVE REPLACE

# Helper functions
function fr(){
    FIND="$1"
    REPLACE="$2"
    shift 2
    for e in $(git ls-files "$@" -- "*.[ch]")
    do
        sed --follow-symlinks -i "s/$FIND/$REPLACE/g" $e
    done
}

function rccheckbin()
{
	if test "$#" != "1"; then
		return 1	
	fi

	which "$1" 2>&1 > /dev/null
	
	if test "$?" != "0"; then
		debugrc "You need to install $1"
		return 1
	else
		return 0
	fi
}


# Aliases
#
#

if rccheckbin "bat"; then
	alias cat="bat -A"
fi

if rccheckbin "lsd"; then
	alias ls=lsd
fi

if rccheckbin "rg"; then
	alias g="rg -A 1 -B 1"
fi

if rccheckbin python3.9 > /dev/null; then
	alias python3="python3.9"
fi

if rccheckbin pip3.9 > /dev/null; then
	alias pip3="pip3.9"
fi

if rccheckbin "keychain"; then
	eval $(keychain --eval --agents ssh id_rsa_pmi -q)
fi
# PS1
#
#

export PROMPT="%F{blue}[%?] %F{green}%n%F{reset}@%F{red}%m%F{reset} %~ ${NL} %# "
export PAGER="less -R"
export PS1="$PROMPT"

# Some Paths
#
#

export MANPATH=/usr/share/man:$MANPATH
export PATH=/home/jbbesnard/usr/bin/:$PATH

if test -f ~/.local_rc; then
	. ~/.local_rc
else
	echo "Created ~/.local_rc for machine local configuration"
	touch ~/.local_rc
fi

