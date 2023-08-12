{ self, config, pkgs, makeMutableSymlink, ... }:
{
  home.packages = with pkgs; [
    fd
    wget
    ripgrep
    (python3.withPackages (ps: with ps; [ dbus-python ]))

    dunst
    kitty
    brave
    discord
    spotify
    playerctl
    rofi-wayland
  ];

  # Create symlinks for all config files
  xdg.configFile = {
    hypr = {
      enable = true;
      recursive = true;
      source = config.lib.file.mkOutOfStoreSymlink "/home/frans/.dotfiles/configs/hypr";
    };
    eww = {
      enable = true;
      recursive = true;
      source = config.lib.file.mkOutOfStoreSymlink "/home/frans/.dotfiles/configs/eww";
    };
    rofi = {
      enable = true;
      recursive = true;
      source = config.lib.file.mkOutOfStoreSymlink "/home/frans/.dotfiles/configs/rofi";
    };
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

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
    ];
  };
}
