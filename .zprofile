# Source global profile (has RVM and shiz)
#emulate ksh -c '. ~/.profile'
autoload zkbd
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line

# Home on top
#export PATH=$HOME/bin:$PATH
export PATH="$HOME/.local/bin:$PATH"

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"
