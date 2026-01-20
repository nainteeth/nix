eval "$(ssh-agent -s)"
fortune | cowsay -r
# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'

eval "$(starship init bash)"
export EDITOR=nvim
export VISUAL=nvim
PATH=$PATH:~/.config/emacs/bin
