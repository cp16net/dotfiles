# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

export GOPATH=$HOME/gospace
export GOBIN=$GOPATH/bin
PATH="/usr/local/sbin:/usr/sbin:/sbin:$PATH:/usr/local/go/bin:$GOBIN"

#export PATH="$HOME/.cargo/bin:$PATH"

### npm local global setup
#export PATH=~/.npm-global/bin:${PATH}
#export NPM_CONFIG_PREFIX=~/.npm-global

#export PATH="$HOME/.poetry/bin:$PATH"

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
