{ config, pkgs, unstable-pkgs, makeMutableSymlink, ...}:
{
  home.packages = with pkgs; [
    wofi
    brave
  ];

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
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
