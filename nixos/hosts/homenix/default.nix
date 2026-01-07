{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ../common/core.nix

    inputs.dankMaterialShell.nixosModules.greeter
  ];

  networking.hostName = "homenix";

  programs.steam.enable = true;

  programs.dank-material-shell.greeter = {
    enable = true;
    compositor = {
      name = "niri"; # Required. Can be also "hyprland" or "sway"
    };

    # Sync your user's DankMaterialShell theme with the greeter. You'll probably want this
    configHome = "/home/frans";

    # Custom config files for non-standard config locations
    configFiles = [ "/home/frans/.config/DankMaterialShell/settings.json" ];

    # Custom Quickshell Package
    quickshell.package = pkgs.quickshell;
  };
}
