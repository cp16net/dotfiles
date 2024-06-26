# dotfiles
## Getting started with homeshick

``` bash
git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
source "$HOME/.homesick/repos/homeshick/homeshick.sh"
source "$HOME/.homesick/repos/homeshick/completions/homeshick-completion.bash"
homeshick clone https://github.com/cp16net/dotfiles.git
homeshick link dotfiles
```

# notes

I've been using [spacemacs](https://github.com/syl20bnr/spacemacs/) for a few months and its been pretty nice. Its pretty easy to setup and i've been using the develop branch instead of just the master branch.

## Quick Install:

```bash
git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
cd ~/.emacs.d && git checkout develop
```

# other programs

## fzf
https://github.com/junegunn/fzf

``` bash
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
```

## bat
https://github.com/sharkdp/bat/releases/latest

## slack
https://slack.com/downloads/linux

## vscode
https://code.visualstudio.com/Download or `sudo snap install code --classic`

## spotify
`sudo snap install spotify`

## node
`sudo snap install node --classic`

## golang
https://golang.org/dl/

# snaps installed

``` bash
sudo snap install htop
sudo snap install http
sudo snap install postman
sudo snap install btop
sudo snap install yq
sudo snap install vlc
sudo snap install gimp
sudo snap install emacs --classic
sudo snap install code --classic
sudo snap install k9s
```

# packages isntalled

``` bash
sudo apt install zsh git
```