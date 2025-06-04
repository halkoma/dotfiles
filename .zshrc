# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"
# ZSH_THEME="gnzh"

function plugins () {
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  git clone https://github.com/wting/autojump ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/autojump && (cd ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/autojump && ./install.py)
}

plugins=(
  zsh-autosuggestions
  autojump
)

# fzf
FZF_DEFAULT_COMMAND="fdfind . --hidden --follow --exclude .git"  # $HOME"
FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
FZF_ALT_C_COMMAND='fdfind . --type d --hidden --follow --exclude .git'
FZF_DEFAULT_OPTS='--preview "batcat --style=header,grid --color=always --line-range :300 {}" --height 70% --bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down --preview-window=bottom,80%'
export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --color header:italic
  --header 'Press CTRL-Y to copy command into clipboard'"

# autojump
[[ -s $HOME/etc/profile.d/autojump.sh ]] && source $HOME/etc/profile.d/autojump.sh
autoload -U compinit && compinit -u

# User configuration

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
#   HISTCONTROL=ignoreboth
#   # append to the history file, don't overwrite it
#   setopt APPEND_HISTORY
#   # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=3000000
HISTFILESIZE=3000000
HISTFILE=~/.zsh_history
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

# Key bindings
# This is for ctrl+u work similar to bash and NOT kill the whole line
bindkey \^U backward-kill-line

# run s/search/replace/gc on stuff found with grep
# here, the c in gc means that it asks for confirmation
# usage:
# replace replace_this with_this
replace () {
    if [ "$#" -ne 2 ]; then
        echo "Must be 2 parameters: e.g. 'replace replace_this with_this'"
        return 1
    fi

    limit=50  # if more than 50 grep results found, do nothing
    search="$1"
    replace="$2"
    results=$(grep -rl --color=never "$search")
    length=$(echo "$results" | wc -l)

    if [ "$length" -ne 0 ] && [ "$length" -lt "$limit" ]; then
        echo "$results" | while IFS= read -r file
        do
            nvim -c "%s/$search/$replace/gc" -c 'wq' "$file"
        done
    else
        echo "$length results found, nothing done"
    fi
}

findedit () {
    if [ "$#" -ne 1 ]; then
        echo "Must be 1 parameter"
        return 1
    fi

    searchterm="$1"
    rg -l "$searchterm" | \
      fzf --preview "batcat --style=header,grid --color=always --line-range :300 {}" --height 70% --bind ctrl-u:preview-half-page-up,ctrl-d:preview-half-page-down --preview-window=bottom,80% | \
      xargs -o nvim
}

source $ZSH/oh-my-zsh.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias aliases="tac ~/.zshrc | awk -v RS= NR==1 | tac"
alias ls="ls -A -F --group-directories-first --sort=extension --color=auto"
alias virtualbox='virtualbox & > /dev/null 2>&1'
alias vim=/usr/bin/nvim
alias nvimc="vim ~/.config/nvim/{init.lua,lua/*}"
alias nb="vim ~/.bashrc"
alias nz="vim ~/.zshrc"
alias sb="source ~/.bazshrc"
alias sz="source ~/.zshrc"
alias bat="batcat"
alias bark="paplay /usr/share/sounds/gnome/default/alerts/bark.ogg"
alias barkloop="for i in {1..3}; do bark; done"
alias fd="fdfind"
alias btconnect-j75t="bluetoothctl connect 50:C2:ED:5F:19:41"
alias btdisconnect-j75t="bluetoothctl disconnect 50:C2:ED:5F:19:41"
alias btreconnect="btdisconnect-j75t && btconnect-j75t"
alias 2btconnect-j65="bluetoothctl connect 50:C2:ED:16:96:E0"
alias 2btdisconnect-j65="bluetoothctl disconnect 50:C2:ED:16:96:E0"
alias 2btreconnect-j65="2btdisconnect-j65 && 2btconnect-j65"
alias drawmark="printf '\033[1;33m#############\nLOOK HERE!!!!\n#############\n\n\n\n'"
alias gl="git log"
alias gs="git status"
alias ga="git add"
alias gp="git pull"
alias gd="git diff"
alias gd1="git diff HEAD^"
alias gd2="git diff HEAD^^"
alias gw="git diff --word-diff=porcelain"
