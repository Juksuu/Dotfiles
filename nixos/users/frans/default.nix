{ pkgs, ... }:
{
  users.users.frans = {
    isNormalUser = true;
    home = "/home/frans";
    description = "Frans";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    nvidiaPatches = true;
  };
}
