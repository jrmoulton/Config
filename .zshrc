ZSH_DISABLE_COMPFIX=true

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.config/scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export JDTLS_HOME="$HOME/Downloads/jdt-language-server-1.7.0-202112161541/"

# Environment variables
export EDITOR=nvim

ZSH_THEME="robbyrussell"
zstyle ':completion:*' menu select

plugins=(
	zsh-syntax-highlighting
	zsh-autosuggestions
	colored-man-pages
	colorize
  )

# Start oh-my-zsh and starship
source $ZSH/oh-my-zsh.sh
export STARTSHIP_CONFIG="$HOME/.config/starship.toml"
eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd j)"
if [[ "$(uname -s)" == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
else
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source /home/linuxbrew/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Add aliases
alias ohmyzsh="mate ~/.oh-my-zsh"
alias vim=nvim
alias ls=exa
alias z=zoxide
alias tec="tectonic -X"
alias tms=tmux-sessionizer
eval $(thefuck --alias)
alias pythonten="/opt/homebrew/opt/python@3.10/bin/python3.10"

# Git alaiases
alias gaa="git add --all"
alias gap="git add -p"
alias gb="git branch"
alias gcb="git checkout -b"
alias gc="git checkout"
alias gcm="git checkout main"
alias gf="git fetch"
alias gm="git merge"
alias gp="git push"
alias gs="git status"
alias gss="git status -s"
alias glogg="git log --graph --pretty=oneline --decorate --abbrev-commit"
alias glog="git log --pretty=oneline --decorate --abbrev-commit -n 10"
alias gk="git commit -m"
alias gwa="git-worktree-add"



# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# Other keybindings
bindkey '^ ' autosuggest-accept

# set up fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --ignore-vcs --follow'
export FZF_DEFAULT_OPTS='--bind=ctrl-u:up,ctrl-d:down'

tmux source-file ~/.config/tmux/.tmux.conf

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
elif [ -z $TMUX ]; then
 	# if tmux is not running then start a session
 	tmux new-session -A -s _config -c $HOME/.config
fi

