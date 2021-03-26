#!/bin/zsh
# Path to your oh-my-zsh installation.
export ZSH=/Users/zeleznick/.oh-my-zsh

#use z instead of cd via http://jilles.me/badassify-your-terminal-and-shell/
. `brew --prefix`/etc/profile.d/z.sh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="zz"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)

# User configuration

export PATH="/usr/local/ncbi/blast/bin:/usr/local/bin/samtools-1.2:/usr/local/bin/bwa-0.7.12:/usr/local/bin/HDMan:/Users/zeleznick/bioe131:/usr/local/bin/csslint:/usr/local/bin/jsxhint:/Applications/MAMP/bin/php/php5.4.26/bin:/usr/local/bin/python:/usr/local/bin/ipython:/usr/local/bin:/Users/zeleznick/.rvm/gems/ruby-2.0.0-p481@railstutorial_rails_4_0/bin:/Users/zeleznick/.rvm/gems/ruby-2.0.0-p481@global/bin:/Users/zeleznick/.rvm/rubies/ruby-2.0.0-p481/bin:/Users/zeleznick/CS194/hacks/meals/menuparser.py:/Applications/MAMP/bin/php/php5.4.26/bin:/Users/zeleznick/wine/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/usr/local/ncbi/blast/bin:/usr/texbin:/Users/zeleznick/.rvm/bin:/usr/local/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh
BATTERY="/Users/zeleznick/config/battery.py"
# via http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.

# A L I A S  I D E A S
# https://news.ycombinator.com/item?id=9869231


# Z S H  A L I A S E S

alias zshrc="subl ~/.zshrc" # Quick access to the ~/.zshrc file
alias ohmyzsh="subl ~/.oh-my-zsh"
alias battery="python ~/config/battery.py"

# S Y S  U T I L S
alias mem='top -l1 | grep PhysMem'
alias diskspace="du -S | sort -n -r |less"
alias jekyll="/usr/local/bin/jekyll"
alias ruby="/usr/local/Cellar/ruby/2.2.4/bin/ruby"
alias gem="/usr/local/Cellar/ruby/2.2.4/bin/gem"
alias heroku="/usr/local/heroku/bin/heroku"

# P Y T H O N  U T I L S
alias pserve='python -m SimpleHTTPServer 8000'
alias vv='virtualenv .env'
alias activate='source .env/bin/activate; source .env/bin/postactivate'
alias freeze='pip freeze > requirements.txt'

# E X T E R N A L  U T I L S
alias myip="curl icanhazip.com" # Your public IP address
alias yt='cd $HOME/downloads; youtube-dl --verbose'
alias glog='git log --oneline --decorate --color --graph'
# ruby gem for wifi password
alias wifi="wifi-password"

# CS 161
alias neo="ssh -p 16103 neo@127.0.0.1"

# Z Z  U T I L S
alias text='osascript ~/config/sendmsg.applescript'
# text a number from my iphone
alias textr='osascript ~/config/sendmsg.applescript 17145525343'
alias textjosh='osascript ~/config/sendmsg.applescript 15187445943'

# alias pymail="/usr/local/zz_py/mail.py"
# send a hard-coded message via bmail

alias zmail="/usr/local/zz_py/gmail.py"
# send a message through terminal via gmail

alias prog="~/config/progress.py"
# show a cute progress bar

alias tasks="python ~/tasker/code/tasker.py"
alias maze="python ~/python-projects/Maze/main.py"
alias menu="python3 ~/feedBot/heroku_main/menu.py"


# D I R E C T O R I ES
alias pypy="cd ~/python-practice"
alias bioe="cd ~/bioe131"
alias zzpy="cd /usr/local/zz_py"

# SYNTAX highlighting via http://jilles.me/badassify-your-terminal-and-shell/
source ~/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh


# added by travis gem
[ -f /Users/zeleznick/.travis/travis.sh ] && source /Users/zeleznick/.travis/travis.sh

# Torch installation
. /Users/zeleznick/torch/install/bin/torch-activate

# The next line updates PATH for the Google Cloud SDK.
if [ -f /Users/zeleznick/google-cloud-sdk/path.zsh.inc ]; then
  source '/Users/zeleznick/google-cloud-sdk/path.zsh.inc'
fi

# The next line enables shell command completion for gcloud.
if [ -f /Users/zeleznick/google-cloud-sdk/completion.zsh.inc ]; then
  source '/Users/zeleznick/google-cloud-sdk/completion.zsh.inc'
fi
