ZSH_DISABLE_COMPFIX=true

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.config/scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"


export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk-16.0.1.jdk/Contents/Home/"
export JDTLS_HOME="$HOME/Downloads/jdt-language-server-1.9.0-202201270134/"

# Environment variables
export EDITOR=nvim
export RUSTC_FORCE_INCREMENTAL=1

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
export STARTSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd cdd)"
# eval "$(op signin my)
eval "$(op completion zsh)"; compdef _op op
if [[ "$(uname -s)" == "Darwin" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
    alias j16="export JAVA_HOME=`/usr/libexec/java_home -v 16`; java -version"
    alias j11="export JAVA_HOME=`/usr/libexec/java_home -v 11`; java -version"
else
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    source /home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source /home/linuxbrew/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    export PATH="/media/jaredmoulton/9a125138-5627-477a-8b01-6d090b2f61bc/tools/Xilinx/Vivado/2021.1/bin:$PATH"
    # alias j16="export JAVA_HOME=`/usr/libexec/java_home -v 16`; java -version"
    # alias j11="export JAVA_HOME=`/usr/libexec/java_home -v 11`; java -version"
fi

# Add aliases
alias ohmyzsh="mate ~/.oh-my-zsh"
alias vim=nvim
alias vim.="nvim ."
alias ls=exa
alias tec="tectonic -X"
alias tmk="tms kill"
alias pythonten="/opt/homebrew/opt/python@3.10/bin/python3.10"
alias sqlite=sqlite3
alias email="cmdg -sign"

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
alias gss="git status"
alias gs="git status -s"
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
export FZF_DEFAULT_COMMAND='fd --type file'
# export FZF_DEFAULT_OPTS="--ansi"
export FZF_DEFAULT_OPTS='--bind=ctrl-u:up,ctrl-d:down'

tmux source-file ~/.config/tmux/tmux.conf

###### Really don't put stuff beneath this. What happens after this won't
# necessarily affecty the current running shell

# # if we are in vscode then create/ attach to vscode session and create new window
#if [ "$TERM_PROGRAM" = "vscode" ];  then
#	#Get the current working directory to use as the session name
#	# The exec stuff is so that if there is a duplicate session the error is not
#	# printed to stdout
#	SESSION=`pwd | rg "[^/]+$" -o`
#	exec 3>&2
#	exec 2> /dev/null
#	tmux new-session -s $SESSION -d
#	exec 2>&3
#	tmux new-window -t $SESSION
#	if [ -d ".venv" ]; then
#		tmux send-keys -t $SESSION 'source .venv/bin/activate' Enter
#	fi
#	tmux attach-session -t $SESSION
if [ -z $TMUX ]; then
 	# if tmux is not running then start a session
 	tmux new-session -A -s _config -c $HOME/.config
fi
