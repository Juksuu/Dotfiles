{ pkgs, ... }: {
  users.users.frans = {
    isNormalUser = true;
    home = "/home/frans";
    description = "Frans";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  home-manager.users.frans = import ./home.nix;
}
