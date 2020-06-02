set -x PATH $PATH /home/frans/.local/bin /home/frans/.yarn/bin $HOME/.cargo/bin

set -x GTK_IM_MODULE ibus
set -x XMODIFIERS @im=ibus
set -x QT_IM_MODULE ibus

set -x VISUAL nvim
set -x EDITOR $VISUAL

set fish_greeting

function nvm
   bass source /usr/share/nvm/nvm.sh --no-use ';' nvm $argv
end

set -x NVM_DIR ~/.nvm
nvm use default --silent

alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'