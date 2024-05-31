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
export MODULAR_HOME="$HOME/.modular"
export PATH="$MODULAR_HOME/pkg/packages.modular.com_mojo/bin:$PATH"


export RUST_GDB="arm-none-eabi-gdb"

export CARGO_TARGET_DIR="/Users/jaredmoulton/.cargo/target"

# Environment variables
export EDITOR=hx
export RUSTC_FORCE_INCREMENTAL=1

ZSH_THEME="robbyrussell"
zstyle ':completion:*' menu select


eval "$(/opt/homebrew/bin/brew shellenv)"
if [[ "$(uname -s)" == "Darwin" ]]; then
    # alias j16="export JAVA_HOME=`/usr/libexec/java_home -v 16`; java -version"
    # alias j11="export JAVA_HOME=`/usr/libexec/java_home -v 11`; java -version"
else
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    export PATH="/media/jaredmoulton/9a125138-5627-477a-8b01-6d090b2f61bc/tools/Xilinx/Vivado/2021.1/bin:$PATH"
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

# zstyle ':fzf-tab:*' fzf-command fzf
# # disable sort when completing `git checkout`
# zstyle ':completion:*:git-checkout:*' sort false
# # set descriptions format to enable group support
# zstyle ':completion:*:descriptions' format '[%d]'
# # set list-colors to enable filename colorizing
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# # preview directory's content with exa when completing cd
# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# # switch group using `,` and `.`
# zstyle ':fzf-tab:*' switch-group ',' '.'
# zstyle ':fzf-tab:*' fzf-min-height 15
# zstyle ':fzf-tab:*' fzf-min-width 15


# # it is an example. you can change it
# zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview \
# 	'git diff $word | delta'
# zstyle ':fzf-tab:complete:git-log:*' fzf-preview \
# 	'git log --color=always $word'
# zstyle ':fzf-tab:complete:git-help:*' fzf-preview \
# 	'git help $word | bat -plman --color=always'
# zstyle ':fzf-tab:complete:git-show:*' fzf-preview \
# 	'case "$group" in
# 	"commit tag") git show --color=always $word ;;
# 	*) git show --color=always $word | delta ;;
# 	esac'
# zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview \
# 	'case "$group" in
# 	"modified file") git diff $word | delta ;;
# 	"recent commit object name") git show --color=always $word | delta ;;
# 	*) git log --color=always $word ;;
# 	esac'

# enable-fzf-tab



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

