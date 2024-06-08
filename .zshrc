# Zi
if [[ -r "${XDG_CONFIG_HOME:-${HOME}/.config}/zi/init.zsh" ]]; then
  source "${XDG_CONFIG_HOME:-${HOME}/.config}/zi/init.zsh" && zzinit
fi
# Homebrew (done in .zprofile)
#eval "$(/opt/homebrew/bin/brew shellenv)"

# Returns whether the given command is executable or aliased.
_has() {
  return $( whence $1 >/dev/null )
}

# Load direnv before instant prompt
if _has direnv; then emulate zsh -c "$(direnv export zsh)"; fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Hook direnv after instant prompt
if _has direnv; then emulate zsh -c "$(direnv hook zsh)"; fi

# PyEnv integration
if _has pyenv; then eval "$(pyenv init -)"; fi

# puppetng docker tools
#export PATH=$HOME/Documents/puppet/administration-tools/bin:$PATH
#source $HOME/.puppetng.env

# Hail Zi or Zplug
export ZPLUG_HOME=$HOMEBREW_PREFIX/opt/zplug
if _has zi; then
    # Theme
    zi ice depth=1; zi light romkatv/powerlevel10k
    # oh-my-zsh
    zi snippet OMZP::git
    zi snippet OMZP::command-not-found
    zi snippet OMZL::history.zsh
    zi snippet OMZP::ssh-agent
    # Other
    #zi light hkupty/ssh-agent
    zi light zsh-users/zsh-syntax-highlighting
    zi light zpm-zsh/ls
    #zi light Stealthii/zpm-ls
    zi light MichaelAquilina/zsh-autoswitch-virtualenv
elif [ -d $ZPLUG_HOME ]; then
    source $ZPLUG_HOME/init.zsh

    # Theme
    zplug "romkatv/powerlevel10k", as:theme, depth:1

    # Bundles from oh-my-zsh that I use
    zplug "plugins/git", from:oh-my-zsh
    zplug "plugins/ssh-agent", from:oh-my-zsh
    #zplug "hkupty/ssh-agent"
    zplug "zsh-users/zsh-syntax-highlighting", defer:2
    zplug "plugins/command-not-found", from:oh-my-zsh
    zplug "lib/history", from:oh-my-zsh
    zplug "zpm-zsh/ls"
    zplug "MichaelAquilina/zsh-autoswitch-virtualenv"

    # OSX Plugins
    #zplug "iam4x/zsh-iterm-touchbar"

    # Install plugins if there are plugins that have not been installed
    # Won't work with instant prompt emabled
    # if ! zplug check --verbose; then
    #     printf "Install? [y/N]: "
    #     if read -q; then
    #         echo; zplug install
    #     fi
    # fi

    # Then, source plugins and add commands to $PATH
    zplug load
fi

# ssh-agent
zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent identities id_rsa farset_rsa rehab_rsa

# AG
if _has ag; then
    alias ack=ag
    alias ag='ag --color-path 1\;31 --color-match 1\;32 --color'
fi

# GNU awk, sed
if _has gawk; then alias awk=gawk; fi
if _has gsed; then alias sed=gsed; fi

# NeoVim over Vim
if _has nvim; then
    alias vimdiff='nvim -d'
    alias vim='nvim'
    alias vi='nvim'
fi

# FZF
if [ -e $HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh ]; then
    source $HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh
    source $HOMEBREW_PREFIX/opt/fzf/shell/completion.zsh
fi

# fzf + ag configuration
if _has fzf && _has ag; then
    export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_DEFAULT_OPTS='
    --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108
    --color info:108,prompt:109,spinner:108,pointer:168,marker:168
    '
fi

#Pyenv integration
#eval "$(pyenv init -)"

export PATH="$HOME/.local/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$HOME/go/bin:$PATH"

# frum Ruby manager
if _has frum; then eval "$(frum init)"; fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh