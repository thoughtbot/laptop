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