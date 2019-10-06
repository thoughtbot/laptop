export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"
plugins=(
  git
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

export EDITOR='vim'

alias kl="kubectl"
alias kgp="kl get pods"
alias kgn="kl get nodes"
alias kx="kubectx"
alias ks="kubens"

alias glga="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"


. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

export PATH="/usr/bin:/bin:/usr/sbin:/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"