# ===============================================
# Personal Bash Profile
# ===============================================
#
# This has be lifted from a variety of sources, 
# most of which I can no longer identify.
#
# ===============================================

# Environment variables
# -----------------------------------------------
export TERM="xterm-color"
export EDITOR="subl -n"
export XDG_CONFIG_HOME="~/.config"


# Sets the prompt -- simple, yet colourful.
# -----------------------------------------------
PS1="\033[0;33m[\A]\033[0;32m[\u]\033[0m $ "


# MOTD & Farewell message
# -----------------------------------------------
echo -e "\033[0;31mIn the land of the blind, the one-eyed man is king.\033[0m"

function exit_bash() {
    echo -en "\n\n\033[0;31mBelieve me, I'm still alive...\033[0m" && sleep 3.0
}
trap exit_bash EXIT


# Aliases
# -----------------------------------------------
alias ls="ls -ahlG"
alias irssi="irssi --home=~/.config/irssi"
alias minfo="~/.scripts/minfo.sh"
alias vlc='/Applications/VLC.app/Contents/MacOS/VLC -I rc'


# cd will ls when cd'ing into a new directory
# -----------------------------------------------
function cd() {
  if [ "$1" ]
  then builtin cd "$1" && ls
  else builtin cd && ls
  fi
}

# wgets and then untars
# -----------------------------------------------
function wtar() {
    wget $1 | tar xvf
}


# Enable bash completion
# -----------------------------------------------
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    . $(brew --prefix)/etc/bash_completion
fi


# Start up rbenv
# -----------------------------------------------
export PATH="$HOME/.rbenv/bin:$PATH"
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi


# see https://github.com/imathis/octopress/issues/144
# -----------------------------------------------
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
