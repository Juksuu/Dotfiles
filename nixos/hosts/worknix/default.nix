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

  # Obs camera 
  boot = {
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
    kernelModules = [ "v4l2loopback" ];
    extraModprobeConfig = ''
      options v4l2loopback devices=1 video_nr=1 card_label="OBS Cam" exclusive_caps=1
    '';
  };

  # Enable networking
  networking = {
    hostName = "worknix";
    nftables.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 8080 ];
    };
  };

  environment = {
    systemPackages = with pkgs; [
      # vpn stuff
      openconnect
    ];
  };

  programs.dank-material-shell.greeter = {
    enable = true;
    compositor = {
      name = "niri"; # Required. Can be also "hyprland" or "sway"
    };

    # Sync your user's DankMaterialShell theme with the greeter. You'll probably want this
    configHome = "/home/work";

    # Custom config files for non-standard config locations
    configFiles = [ "/home/work/.config/DankMaterialShell/settings.json" ];

    # Custom Quickshell Package
    quickshell.package = pkgs.quickshell;
  };
}
