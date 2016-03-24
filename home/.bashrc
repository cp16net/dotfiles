#!/bin/bash

if [ "$(uname)" == "Darwin" ]; then
    # Do something under Mac OS X platform

    export CLICOLOR=1
    export LSCOLORS=fxGxBxDxcxegedabagacdx

    export PS1="\[\e[37;40m\]________________________________________________________________________________\n\[\e[32;40m\]\u\e[31;40m\] in \[\e[36;40m\]\w\[\e[33;40m\]\n\e[36;40m\]\h\e[33;40m\]->\$ \[\e[0m\]"

    # MacPorts Installer addition on 2012-02-26_at_19:19:40: adding an appropriate PATH variable for use with MacPorts.
    export PATH=~/bin:/opt/local/bin:/opt/local/sbin:$PATH
    # Finished adapting your PATH environment variable for use with MacPorts.

    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion
    fi

    # export DEFAULT_SUPERNOVA_ENV=fabric-inova-ord
    # alias emacs='emacs-24.3'
    export EDITOR=emacs
    export VAGRANT_DEFAULT_PROVIDER='vmware_fusion'

    # trove vagrant vm memory default
    # export TROVE_VM_MEMORY=4096

    alias ll="ls -al"
    alias la='ls -A'
    alias l='ls -CF'

    alias sublime='open -a Sublime\ Text .'
    # alias cdb='cd ~/code/private/Cloud-Database/'
    alias pt='cd ~/code/public/trove'
    alias ptv='cd ~/code/public/trove-vagrant-vmware'
    # alias cdbv='cd ~/code/private/Cloud-Database/vagrant/puppet'
    alias public='cd ~/code/public/'
    # alias fabhelper='cd ~/code/backup/code/helpers/; workon supernova'
    alias irc="ssh -t irc 'screen -dr'"

    export PATH=/usr/local/mysql/bin:$PATH
    export DYLD_LIBRARY_PATH=/usr/local/mysql/lib/

    # added these 2 flags for pycrpto to install with pip
    export CFLAGS=-Qunused-arguments
    export CPPFLAGS=-Qunused-arguments

    irssi_notifier() {
        ssh irc 'echo -n "" > ~/.irssi/fnotify; tail -f ~/.irssi/fnotify' | \
            while read heading message; do
                url=`echo \"$message\" | grep -Eo 'https?://[^ >]+' | head -1`;

                if [ ! "$url" ]; then
                    terminal-notifier -title "\"$heading\"" -message "\"$message\"" -activate com.googlecode.iTerm2;
                else
                    terminal-notifier -title "\"$heading\"" -message "\"$message\"" -open "\"$url\"";
                fi;
            done
    }
    if [ 2 -gt $(ps axu | grep fnotify | wc -l | xargs) ]; then
        irssi_notifier &
    fi

    # adding bash completion for vagrant
    if [ -f `brew --prefix`/etc/bash_completion.d/vagrant ]; then
        source `brew --prefix`/etc/bash_completion.d/vagrant
    fi

    PERL_MB_OPT="--install_base \"/Users/craig.vyvial/perl5\""; export PERL_MB_OPT;
    PERL_MM_OPT="INSTALL_BASE=/Users/craig.vyvial/perl5"; export PERL_MM_OPT;

    # swap ssh configs
    # alias swapsshhome='cp ~/.ssh/home.config ~/.ssh/config'
    # alias swapsshwork='cp ~/.ssh/work.config ~/.ssh/config'
    # alias sshw='ssh -F ~/.ssh/work.config $@'

    # to build lxml on mac 10.9
    STATIC_DEPS=true

elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
    # Do something under Linux platform

    # ~/.bashrc: executed by bash(1) for non-login shells.
    # see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
    # for examples

    # If not running interactively, don't do anything
    case $- in
        *i*) ;;
        *) return;;
    esac

    # don't put duplicate lines or lines starting with space in the history.
    # See bash(1) for more options
    HISTCONTROL=ignoreboth

    # append to the history file, don't overwrite it
    shopt -s histappend

    # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
    HISTSIZE=1000
    HISTFILESIZE=2000

    # check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS.
    shopt -s checkwinsize

    # If set, the pattern "**" used in a pathname expansion context will
    # match all files and zero or more directories and subdirectories.
    #shopt -s globstar

    # make less more friendly for non-text input files, see lesspipe(1)
    #[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

    # set variable identifying the chroot you work in (used in the prompt below)
    if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
        debian_chroot=$(cat /etc/debian_chroot)
    fi

    # set a fancy prompt (non-color, unless we know we "want" color)
    case "$TERM" in
        xterm-color) color_prompt=yes;;
    esac

    # uncomment for a colored prompt, if the terminal has the capability; turned
    # off by default to not distract the user: the focus in a terminal window
    # should be on the output of commands, not on the prompt
    force_color_prompt=yes

    if [ -n "$force_color_prompt" ]; then
        if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
            # We have color support; assume it's compliant with Ecma-48
            # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
            # a case would tend to support setf rather than setaf.)
            color_prompt=yes
        else
            color_prompt=
        fi
    fi

    if [ "$color_prompt" = yes ]; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
    else
        PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
    fi
    unset color_prompt force_color_prompt

    # If this is an xterm set the title to user@host:dir
    case "$TERM" in
        xterm*|rxvt*)
            PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
            ;;
        *)
            ;;
    esac

    # enable color support of ls and also add handy aliases
    if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='ls --color=auto'
        alias dir='dir --color=auto'
        alias vdir='vdir --color=auto'

        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
    fi

    # some more ls aliases
    alias ll='ls -la'
    alias la='ls -A'
    alias l='ls -CF'

    # Alias definitions.
    # You may want to put all your additions into a separate file like
    # ~/.bash_aliases, instead of adding them here directly.
    # See /usr/share/doc/bash-doc/examples in the bash-doc package.

    if [ -f ~/.bash_aliases ]; then
        . ~/.bash_aliases
    fi

    # enable programmable completion features (you don't need to enable
    # this, if it's already enabled in /etc/bash.bashrc and /etc/profile
    # sources /etc/bash.bashrc).
    if ! shopt -oq posix; then
        if [ -f /usr/share/bash-completion/bash_completion ]; then
            . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
            . /etc/bash_completion
        fi
    fi

#    export VAGRANT_DEFAULT_PROVIDER=libvirt
    export WORKON_HOME=$HOME/.virtualenvs
    export PROJECT_HOME=$HOME/Devel

fi

export EDITOR="emacs"
PS1='[${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 " (%s)")\$ '
export LSCOLORS=ExFxCxDxBxegedabagacad

alias clean_pyc_files='find . -name "*.pyc" -exec rm -rf {} \;'
alias uuid="python -c 'import sys,uuid; sys.stdout.write(uuid.uuid4().hex)' | pbcopy && pbpaste && echo"

export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
source /usr/local/bin/virtualenvwrapper_lazy.sh
source "$HOME/.git-completion.sh"

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"
