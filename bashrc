if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

export PATH=/opt/local/Library/Frameworks/Python.framework/Versions/Current/bin:/opt/local/bin:/opt/local/sbin:$PATH
export MANPATH=/opt/local/man:/opt/local/share/man:$MANPATH
export INFOPATH=$INFOPATH:/opt/local/share/info
# export PYTHONPATH=$PYTHONPATH:$HOME/dev/site-packages/

export EDITOR=emacs
export LSCOLORS=gxfxcxdxBxDaDaxBxBxeHG
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=1;31:su=41:sg=41:bd=1;33;40:cd=1;33;40:ow=1;7;36:tw=44'

export LESS='-R'  # ask less to handle ANSI colors
export NNTPSERVER='news.gazeta.pl' # default newsgroup server address for slrn

# UTF-8 in pbcopy
export __CF_USER_TEXT_ENCODING=0x1F5:0x8000100:0x8000100


PS1='[\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w\[\033[00m\]]\$ '

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    #eval "`dircolors -b`"
    whichls=`which ls`
    if [ "$whichls" = "/opt/local/bin/ls" ]; then
        alias ls='ls --color=auto --group-directories-first'
    elif [ "$whichls" = "/bin/ls" ]; then
        alias ls='ls -G'
    fi
    alias grep='grep --color=auto'
fi

# place your aliases below:
alias clc='clear'
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'
alias updatedb='sudo /usr/libexec/locate.updatedb'
alias pyclean='find . -name "*.pyc" -exec rm {} \;'
alias whatsmyip='ifconfig | tail -12 | grep -m 1 -oP "(\d{1,3}\.){3}\d{1,3}" --color=no | tail -1'

alias share='python -m SimpleHTTPServer'
alias node_repl='rlwrap node-repl'
alias js='rlwrap js -version 170'
alias rhino='java -cp js.jar:lib/jline-0.9.93.jar org.mozilla.javascript.tools.shell.Main'
alias jsc='/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Resources/jsc'

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
export WORKON_HOME=$HOME/dev/virtualenvs
source /opt/local/Library/Frameworks/Python.framework/Versions/2.6/bin/virtualenvwrapper_bashrc