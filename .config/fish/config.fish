set -x PATH $PATH $HOME/.local/bin $HOME/.yarn/bin $HOME/.cargo/bin $HOME/.ghcup/bin /var/lib/snapd/snap/bin
set -x VISUAL nvim
set -x EDITOR $VISUAL

set fish_greeting

function nvm
   bass source /usr/share/nvm/nvm.sh --no-use ';' nvm $argv
end

set -x NVM_DIR ~/.nvm
nvm use default --silent

alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
