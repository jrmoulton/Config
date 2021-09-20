ZSH_DISABLE_COMPFIX=true
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export PATH="$HOME/.cargo/bin:$PATH"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
zstyle ':completion:*' menu select

plugins=(
	git
	vi-mode
	zsh-syntax-highlighting
	zsh-autosuggestions
	colored-man-pages
	colorize
	autojump
  )

source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"

# Add aliases
alias ohmyzsh="mate ~/.oh-my-zsh"
alias c=clear
alias vim=nvim
alias ls=exa
alias cat=bat

alias gaa=git add all
alias gb=git branch
alias gc=git clone
alias gcb=git checkout -b
alias gcm=git checkout master
alias gdca=git diff --chached
alias gf=git fetch
alias gm=git merge
alias gp=git push
eval $(thefuck --alias)


# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

bindkey '^ ' autosuggest-accept
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

tmux source-file ~/.config/tmux/.tmux.conf

export FZF_DEFAULT_COMMAND='rg --files --ignore-vcs'
