set -x VISUAL nvim
set -x EDITOR $VISUAL

set -x GOPATH $HOME/go
set -x PATH $PATH $HOME/.local/bin $HOME/.yarn/bin $HOME/.cargo/bin $HOME/.ghcup/bin $GOPATH/bin

set fish_greeting
source ~/.config/fish/themes/ayu_mirage.fish

function nvm
   bass source $HOME/.nvm/nvm.sh --no-use ';' nvm $argv
end

set -x NVM_DIR ~/.nvm
nvm use default --silent

alias config='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias tmx='$HOME/scripts/tmux.sh'

# fish_ssh_agent
