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

  home.file = {
    # Scripts
    "scripts".source =
      config.lib.file.mkOutOfStoreSymlink "/home/frans/.dotfiles/scripts";

    # .config entries
    ".config/hypr".source =
      config.lib.file.mkOutOfStoreSymlink "/home/frans/.dotfiles/configs/hypr";
    ".config/eww".source =
      config.lib.file.mkOutOfStoreSymlink "/home/frans/.dotfiles/configs/eww";
    ".config/rofi".source =
      config.lib.file.mkOutOfStoreSymlink "/home/frans/.dotfiles/configs/rofi";
    ".config/nvim".source =
      config.lib.file.mkOutOfStoreSymlink "/home/frans/.dotfiles/configs/nvim";
    ".config/kitty".source =
      config.lib.file.mkOutOfStoreSymlink "/home/frans/.dotfiles/configs/kitty";
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
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
      wtc = "~/scripts/wtc.sh";
      wts = "bass source ~/scripts/wts.sh";
    };
    plugins = [
      { name = "bass"; src = pkgs.fishPlugins.bass.src; }
    ];
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
