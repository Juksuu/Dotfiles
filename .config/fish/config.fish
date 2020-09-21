set -x PATH $PATH $HOME/.local/bin $HOME/.yarn/bin $HOME/.cargo/bin $HOME/.ghcup/bin $HOME/.cabal/bin /var/lib/flatpak/exports/bin/

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

alias nvimConf='nvim ~/.config/nvim/init.vim'
alias fishConf='nvim ~/.config/fish/config.fish'
alias xmonadConf='nvim ~/.xmonad/xmonad.hs'
alias xmobarConf='nvim ~/.config/xmobar/xmobarrc'
alias kittyConf='nvim ~/.config/kitty/kitty.conf'
