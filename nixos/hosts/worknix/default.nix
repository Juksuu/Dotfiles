{ inputs, lib, config, pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ../common/core.nix
    ../common/plasma6.nix
  ];

  # Obs camera
  boot = {
    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];
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
      steam-run

      # vpn stuff
      openconnect
    ];
  };
}
