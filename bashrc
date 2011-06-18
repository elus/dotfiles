if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

# VARIABLES
export PATH=/opt/local/Library/Frameworks/Python.framework/Versions/Current/bin:/opt/local/libexec/gnubin:/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/man:/opt/local/share/man:$MANPATH
export INFOPATH=$INFOPATH:/opt/local/share/info
export EDITOR=emacs
export LESS='-R'  # ask less to handle ANSI colors
export NNTPSERVER='news.gazeta.pl' # default newsgroup server address for slrn
export __CF_USER_TEXT_ENCODING=0x1F5:0x8000100:0x8000100 # UTF-8 in pbcopy

export LANG="en_GB.UTF-8" # default language
export LC_TYPE=$LANG      # babel needs that

PS1='[\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]]\$ '

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    if ls --color -d . >/dev/null 2>&1; then # GNU ls
        #eval "`dircolors -b`"
        export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=1;31:su=41:sg=41:bd=1;33;40:cd=1;33;40:ow=1;7;36:tw=44'
        alias ls='ls --color=auto --group-directories-first'
    elif ls -G -d . >/dev/null 2>&1; then # BSD ls
        export LSCOLORS=gxfxcxdxBxDaDaxBxBxeHG
        alias ls='ls -G'
    fi
    alias grep='grep --color=auto'
fi

# place your aliases below:
if [ -x "`which gnome-open`" ]; then
    alias o='gnome-open'
elif [ -x "`which kde-open`" ]; then
    alias o='kde-open'
elif [ -x "`which open`" ]; then
    alias o='open'
fi
alias clc='clear'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias pyclean='find . -type f -name "*.pyc" -exec rm {} \;'
alias share='python -m SimpleHTTPServer'

# UTILITY FUNCTIONS
unp() { # easy unpacking
    if [ x == x$1 ]; then
        echo 'usage: unp [filename]'
    elif [ -f "$1" ]; then
        case "$1" in
            *.tar.gz)          tar xvzf "$1" ;;
            *.tgz)             tar xvzf "$1" ;;
            *.tar.bz2)         tar xvjf "$1" ;;
            *.gz)              gunzip "$1" ;;
            *.bz2)             bunzip2 "$1" ;;
            *.tar)             tar zvf "$1" ;;
            *.zip|*.egg|*.jar) unzip "$1" ;;
            *) echo "'$1' is an unknown archive" ;;
        esac
    else
        echo "'$1' is not a valid archive"
    fi
}

# BASH OPTIONS
shopt -s autocd 2> /dev/null

# BASH COMPLETION
if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi
if [ -f /opt/local/etc/bash_completion ]; then
    . /opt/local/etc/bash_completion
fi

# pip bash completion start
_pip_completion()
{
    COMPREPLY=( $( COMP_WORDS="${COMP_WORDS[*]}" \
                   COMP_CWORD=$COMP_CWORD \
                   PIP_AUTO_COMPLETE=1 $1 ) )
}
complete -o default -F _pip_completion pip
# pip bash completion end

# django-admin completion
#. ~/dev/libs/django-trunk/extras/django_bash_completion

# virtualenvwrapper
if [ -x "`which virtualenvwrapper.sh`" ]; then
    . virtualenvwrapper.sh
    export WORKON_HOME=$HOME/.envs
    mkdir -p $WORKON_HOME
fi