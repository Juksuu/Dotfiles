{ pkgs, ... }: {
  system.stateVersion = 5;

  nix.optimise.automatic = true;
  nix.settings = { experimental-features = "nix-command flakes"; };

  services.nix-daemon.enable = true;

  fonts.packages = with pkgs; [ nerd-fonts.iosevka maple-mono-NF ];

  environment.systemPackages = with pkgs; [
    jq
    fd
    gcc
    vim
    fzf
    htop
    wget
    ripgrep
    home-manager

    # Programming stuff
    python3
    codespell
    lazydocker
  ];
}
