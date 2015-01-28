export DEFAULT_SUPERNOVA_ENV=fabric-inova-ord
alias emacs='emacs-24.3'
export EDITOR=emacs-24.3
export VAGRANT_DEFAULT_PROVIDER='vmware_fusion'

# trove vagrant vm memory default
export TROVE_VM_MEMORY=4096

alias ll="ls -al"
alias la='ls -A'
alias l='ls -CF'

alias sublime='open -a Sublime\ Text .'
alias cdb='cd ~/code/private/Cloud-Database/'
alias pt='cd ~/code/public/trove'
alias ptv='cd ~/code/public/trove-vagrant-vmware'
alias cdbv='cd ~/code/private/Cloud-Database/vagrant/puppet'
alias tv='cd ~/code/public/trove-vagrant-vmware'
alias tp='cd ~/code/public/trove'
alias public='cd ~/code/public/'
alias clean_pyc_files='find . -name "*.pyc" -exec rm -rf {} \;'
alias fabhelper='cd ~/code/backup/code/helpers/; workon supernova'
alias irc="ssh -t irc 'screen -dr'"

source /Users/craig.vyvial/.git-completion.sh

PS1='[${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]]:\[\033[01;34m\]\w\[\033[00m\]$(__git_ps1 " (%s)")\$ '
export LSCOLORS=ExFxCxDxBxegedabagacad

source /usr/local/bin/virtualenvwrapper.sh
source ~/.profile

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

# adding bash completion for vagrant
if [ -f `brew --prefix`/etc/bash_completion.d/vagrant ]; then
    source `brew --prefix`/etc/bash_completion.d/vagrant
fi

PERL_MB_OPT="--install_base \"/Users/craig.vyvial/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/Users/craig.vyvial/perl5"; export PERL_MM_OPT;

# swap ssh configs
alias swapsshhome='cp ~/.ssh/home.config ~/.ssh/config'
alias swapsshwork='cp ~/.ssh/work.config ~/.ssh/config'
alias sshw='ssh -F ~/.ssh/work.config $@'

# to build lxml on mac 10.9
STATIC_DEPS=true
