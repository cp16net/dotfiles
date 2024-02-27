# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

## goenv init
# eval "$(goenv init -)"
export PATH="/Users/cp16net/bin:/home/cp16net/bin:/usr/local/bin:/usr/bin:/bin:/sbin:/usr/sbin:/usr/local/games:/usr/games:$PATH"

# old go old version for mono repo
# export GOPATH=$HOME/gospace
# export GOBIN=$GOPATH/bin
# export PATH="$GOBIN:$HOME/bin:/usr/local/go/bin:$PATH"



# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="xiong-chiamiov-plus"
#ZSH_THEME="cp16net"
DEFAULT_USER="craig"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git
         python
         pip
         history
         docker
         docker-compose
         golang
         git-extras
         kubectl
         tmuxinator
         z
         # debian
         ubuntu
	       command-not-found
	       common-aliases
        )


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

source "$HOME/.homesick/repos/homeshick/homeshick.sh"
fpath=($HOME/.homesick/repos/homeshick/completions $fpath)

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

export EDITOR=emacs

# export WORKON_HOME=$HOME/.virtualenvs
# export PROJECT_HOME=$HOME/Devel
# # commented this out since ubuntu 17.04 gave some grief with it
# export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3
# #export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python
# export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
# export VIRTUALENVWRAPPER_SCRIPT=/usr/local/bin/virtualenvwrapper.sh
# source /usr/local/bin/virtualenvwrapper_lazy.sh

# tmux window names displaying properly
# export DISABLE_AUTO_TITLE=true

# add rust cmds to path
#export PATH=$PATH:$HOME/.cargo/bin

### npm local global setup
# export PATH=~/.npm-global/bin:${PATH}
# export NPM_CONFIG_PREFIX=~/.npm-global


#
# (cp16net) customized the theme slightly modified from xiong-chiamiov-plus.zsh-theme
# user, host, full path, and time/date
# on two lines for easier vgrepping
# entry in a nice long thread on the Arch Linux forums: http://bbs.archlinux.org/viewtopic.php?pid=521888#p521888
#
# requirements here are that you install `npm install any-json -g` on your system
#
kube_prompt()
{
    # mac is weird and i'm not using it for this anyway
    if [[ $(uname) == "Darwin" ]]; then
	      echo ""
	      return
    fi
    if ! [ -x "$(command -v kubectl)" ]; then
	      echo 'none'
	      return
    fi

    local kubectl_current_context=$(kubectl config current-context)
    local kubectl_current_namespace=$(kubectl config view -o jsonpath="{.contexts[?(@.name==\"${kubectl_current_context}\")].context.namespace}")
    local kubectl_prompt="%b%{\e[0;34m%}%B[%b%{\e[1;37m%}k8s:($fg[cyan]$kubectl_current_context$fg[white]:$fg[cyan]$kubectl_current_namespace%{\e[1;37m%})%{\e[0;34m%}%B]%b%{\e[0m%}"
    echo $kubectl_prompt
}
dir_prompt()
{
    local prompt="%b%{\e[0;34m%}%B[%b%{\e[1;37m%}%~%{\e[0;34m%}%B]%b%{\e[0m%}"
    echo $prompt
}
time_prompt()
{
    local prompt='%{\e[0;34m%}%B[%b%{\e[0;33m%}'%D{"%a %b %d, %H:%M"}%b$'%{\e[0;34m%}%B]%b%{\e[0m%}'
    echo $prompt
}
system_info()
{
    echo '%{\e[0;34m%}%B┌─[%b%{\e[0m%}%{\e[1;32m%}%n%{\e[1;30m%}@%{\e[0m%}%{\e[0;36m%}%m%{\e[0;34m%}%B]%b%{\e[0m%}'
}

PROMPT=$'$(system_info) - $(dir_prompt) - $(kube_prompt) - $(time_prompt)
%{\e[0;34m%}%B└─%B[%{\e[1;35m%}$%{\e[0;34m%}%B] <$(git_prompt_info)>%{\e[0m%}%b '

# NOTE: prompt without kubectl info
#PROMPT=$'%{\e[0;34m%}%B┌─[%b%{\e[0m%}%{\e[1;32m%}%n%{\e[1;30m%}@%{\e[0m%}%{\e[0;36m%}%m%{\e[0;34m%}%B]%b%{\e[0m%} - $(dir_prompt) - $(time_prompt)
#%{\e[0;34m%}%B└─%B[%{\e[1;35m%}$%{\e[0;34m%}%B] <$(git_prompt_info)>%{\e[0m%}%b '

PS2=$' \e[0;34m%}%B>%{\e[0m%}%b '

# export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

if [ -f ~/.zprofile ]; then
    source ~/.zprofile
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/bin/gktl ] && source ~/bin/gktl

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/craig/google-cloud-sdk/path.zsh.inc' ]; then . '/home/craig/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/craig/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/craig/google-cloud-sdk/completion.zsh.inc'; fi

# export PATH="$HOME/.poetry/bin:$PATH"
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
