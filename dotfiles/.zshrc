# ======================
# Homebrew
# ======================
eval "$(/opt/homebrew/bin/brew shellenv)"

# ======================
# Oh My Zsh
# ======================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="zz"
HIST_STAMPS="yyyy-mm-dd"        # ISO 8601 format for `history` command display (must be set before sourcing omz)
plugins=(git)
source $ZSH/oh-my-zsh.sh

# ======================
# History
# ======================
HISTSIZE=50000                  # lines kept in memory per session
SAVEHIST=50000                  # lines persisted to ~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS     # when adding a duplicate, remove the older entry
setopt HIST_FIND_NO_DUPS        # don't show duplicates when searching (ctrl+r)
setopt HIST_REDUCE_BLANKS       # strip extra whitespace before saving
setopt SHARE_HISTORY            # share history across all open terminals in real time
setopt INC_APPEND_HISTORY       # write to history file immediately, not on shell exit

# ======================
# Path
# ======================
export PATH="$HOME/.cargo/bin:$PATH"  # rust/cargo binaries (rustup, bat, rg, etc.)

# ======================
# Environment variables
# ======================
export EDITOR="code --wait"

# ======================
# Navigation
# ======================
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"

# ======================
# Files & directories
# ======================
alias ll="ls -la"
alias la="ls -A"
alias l="ls -CF"
alias mkdir="mkdir -pv"

# ======================
# Git (see also: `ga` or `git aliases` for ~/.gitconfig aliases)
# ======================
alias ga="git config -l | grep alias | sed 's/^alias\.\([^=]*\)=\(.*\)/  git \1\t=> \2/'"
alias gs="git status"
alias gd="git diff"
alias gds="git diff --staged"
alias gl="git log --oneline"
alias gp="git pull"
alias gc="git commit"
alias gca="git commit --amend"
alias gcm="git commit -m"
alias gco="git checkout"
alias gb="git branch"
alias gst="git stash"
alias gstp="git stash pop"

# ======================
# Editor & shell
# ======================
alias c="code ."
alias zshrc="code ~/.zshrc"
alias zshup="source ~/.zshrc"

# ======================
# Utilities
# ======================
alias ip="curl -s ifconfig.me"
alias cls="clear"
alias h="history"
alias ports="lsof -i -P -n | grep LISTEN"
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias mem="top -l1 | grep PhysMem"
alias disk="df -h /"
alias pressure="top -l1 -n0 | grep -E 'CPU|PhysMem|Processes'; sysctl vm.swapusage; memory_pressure 2>/dev/null | grep 'free percentage'; pmset -g therm 2>/dev/null | grep -i warning"
alias hg="history | rg"

# ======================
# Functions (require ~/.local/bin: spin, ask)
# ======================
function checkup { pressure | ask "One-paragraph plain English diagnosis. Is the machine healthy? What is the bottleneck if any? Skip the fluff."; }
