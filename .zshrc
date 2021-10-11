ZSH_DISABLE_COMPFIX=true

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.config/scripts:$PATH"

ZSH_THEME="robbyrussell"
zstyle ':completion:*' menu select

plugins=(
	zsh-syntax-highlighting
	zsh-autosuggestions
	colored-man-pages
	colorize
	autojump
  )

# Start oh-my-zsh and starship
source $ZSH/oh-my-zsh.sh
eval "$(starship init zsh)"

# Add aliases
alias ohmyzsh="mate ~/.oh-my-zsh"
alias vim=nvim
alias ls=exa
eval $(thefuck --alias)

# Git alaiases
alias gaa="git add all"
alias gap="git add -p"
alias gb="git branch"
alias gcb="git checkout -b"
alias gc="git checkout"
alias gcm="git checkout master"
alias gf="git fetch"
alias gm="git merge"
alias gp="git push"
alias gs="git status"
alias glogg="git log --graph --pretty=oneline --decorate --abbrev-commit"
alias glog="git log --pretty=oneline --decorate --abbrev-commit -n 10"



# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Other keybindings
bindkey '^ ' autosuggest-accept

# set up fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --ignore-vcs --follow --hidden'


###### Really don't put stuff beneath this. What happens after this won't
# necessarily affecty the current running shell

# # if we are in vscode then create/ attach to vscode session and create new window
if [ "$TERM_PROGRAM" = "vscode" ];  then
	#Get the current working directory to use as the session name
	# The exec stuff is so that if there is a duplicate session the error is not
	# printed to stdout
	SESSION=`pwd | rg "[^/]+$" -o`
	exec 3>&2
	exec 2> /dev/null
	tmux new-session -s $SESSION -d
	exec 2>&3
	tmux new-window -t $SESSION
	if [ -d ".venv" ]; then
		tmux send-keys -t $SESSION 'source .venv/bin/activate' Enter
	fi
	tmux attach-session -t $SESSION
elif ! { [ "$TERM" = "screen" ] && [ -n "$TMUX" ]; } then
 	# if tmux is not running then start a session
 	tmux
fi

tmux source-file ~/.config/tmux/.tmux.conf

