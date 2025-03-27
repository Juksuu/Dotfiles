{ inputs, lib, config, pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ../common/core.nix
    ../common/hyprland.nix
    ../common/plasma6.nix
  ];

  networking.hostName = "homenix";

  programs.steam.enable = true;
}
