ZSH_DISABLE_COMPFIX=true

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.config/scripts:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/Users/jaredmoulton/.espressif/tools/xtensa-esp32-elf-gcc/8_4_0-esp-2021r2-patch3-aarch64-apple-darwin/bin/:/Users/jaredmoulton/.espressif/tools/xtensa-esp32s2-elf-gcc/8_4_0-esp-2021r2-patch3-aarch64-apple-darwin/bin/:/Users/jaredmoulton/.espressif/tools/xtensa-esp32s3-elf-gcc/8_4_0-esp-2021r2-patch3-aarch64-apple-darwin/bin/:$PATH"
export PATH="/opt/homebrew/opt/python@3.10/bin:$PATH"
export LIBCLANG_PATH="/Users/jaredmoulton/.espressif/tools/xtensa-esp32-elf-clang/esp-14.0.0-20220415-aarch64-apple-darwin/lib/"

export JAVA_HOME="/Users/jaredmoulton/Downloads/jdk-19.0.2.jdk/Contents/Home"

export RUST_GDB="arm-none-eabi-gdb"
export CARGO_TARGET_DIR="$HOME/Programming/.cargo-target"

# Environment variables
export EDITOR=hx
export RUSTC_FORCE_INCREMENTAL=1

ZSH_THEME="robbyrussell"
zstyle ':completion:*' menu select


eval "$(/opt/homebrew/bin/brew shellenv)"
if [[ "$(uname -s)" == "Darwin" ]]; then
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
plugins=(
	zsh-syntax-highlighting
	zsh-autosuggestions
	colored-man-pages
	colorize
)
source $ZSH/oh-my-zsh.sh
tmux source-file ~/.config/tmux/tmux.conf
# Start oh-my-zsh and starship
export STARTSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(starship init zsh)"
eval "$(zoxide init zsh --cmd cdd)"
eval "$(op completion zsh)"; compdef _op op
# eval "$(op signin my)

# Add aliases
alias vim=nvim
alias vim.="nvim ."
alias ls=exa
alias tec="tectonic -X"
alias tmk="tms kill"
alias pythonten="/opt/homebrew/opt/python@3.10/bin/python3.10"
alias sqlite=sqlite3
alias email="cmdg -sign"
alias hx.="hx ."
alias zbr="zig build run"
alias zb="zig build"

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

# fg with Control-f
function fground() { builtin fg}
zle -N fground
bindkey '^f' fground

# set up fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type file'
# export FZF_DEFAULT_OPTS="--ansi"
export FZF_DEFAULT_OPTS='--bind=ctrl-u:up,ctrl-d:down'
# export TERM=xterm-kitty

if [ -z $TMUX ]; then
 	# if tmux is not running then start a session
 	# tmux new-session -A -s _config -c $HOME/.config
    # tms start
fi
