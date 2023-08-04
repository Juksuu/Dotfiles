{ config, pkgs, unstable-pkgs, makeMutableSymlink, ... }:
{
  home.packages = with pkgs; [
    wofi
    brave
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting

      if test -z (pgrep ssh-agent | string collect)
        eval (ssh-agent -c) > /dev/null
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
        set -Ux SSH_AGENT_PID $SSH_AGENT_PID
      end
    '';
    shellAliases = {
      hms = "home-manager switch --flake ~/.dotfiles#frans@homenix";
      nrs = "sudo nixos-rebuild switch --flake ~/.dotfiles#homenix";
    };
  };

  programs.git = {
    enable = true;
    userName = "Frans Paasonen";
    userEmail = "franspaasonen@gmail.com";
  };

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    extraPackages = with pkgs; [
      stylua
      rnix-lsp
      sumneko-lua-language-server
    ];
  };

  # Create symlinks for all config files
  xdg.configFile = {
    nvim = {
      enable = true;
      recursive = true;
      source = config.lib.file.mkOutOfStoreSymlink "/home/frans/.dotfiles/configs/nvim";
    };
    kitty = {
      enable = true;
      recursive = true;
      source = config.lib.file.mkOutOfStoreSymlink "/home/frans/.dotfiles/configs/kitty";
    };
  };
}
