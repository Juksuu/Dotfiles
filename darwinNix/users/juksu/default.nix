{ pkgs, ... }: {
  programs.fish.enable = true;

  users.users.juksu.home = "/Users/juksu";

  system.activationScripts.setFishAsShell.text = ''
    sudo dscl . -create /Users/juksu UserShell /run/current-system/sw/bin/fish
  '';

  home-manager.users.juksu = import ./home.nix;
}
