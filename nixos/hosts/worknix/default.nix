{ inputs, lib, config, pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  system.stateVersion = "24.05";

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = "nix-command flakes";
  };

  # Bootloader.
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  # Enable networking
  networking = {
    hostName = "worknix";
    networkmanager.enable = true;
    nftables.enable = true;
    firewall = {
      enable = true;
      allowedTCPPorts = [ 8080 ];
    };
  };

  # Set your time zone.
  time.timeZone = "Europe/Helsinki";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "fi_FI.UTF-8";
      LC_IDENTIFICATION = "fi_FI.UTF-8";
      LC_MEASUREMENT = "fi_FI.UTF-8";
      LC_MONETARY = "fi_FI.UTF-8";
      LC_NAME = "fi_FI.UTF-8";
      LC_NUMERIC = "fi_FI.UTF-8";
      LC_PAPER = "fi_FI.UTF-8";
      LC_TELEPHONE = "fi_FI.UTF-8";
      LC_TIME = "fi_FI.UTF-8";
    };
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";

      # Disable wayland on mozilla apps for now
      MOZ_ENABLE_WAYLAND = "false";

      # Nvidia specific
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };

    systemPackages = with pkgs; [
      jq
      gcc
      vim
      fzf
      fish
      htop
      alsa-utils
      pavucontrol
      home-manager

      # Wayland stuff
      wl-clipboard
      qt6.qtwayland

      # vpn stuff
      openconnect

      # Programming stuff
      python3
      codespell
      lazydocker
      docker-compose
    ];

    plasma6.excludePackages = with pkgs.kdePackages; [
      elisa
      okular
      oxygen
      khelpcenter
      print-manager
    ];
  };

  hardware = {
    nvidia = {
      open = true;
      modesetting.enable = true;
      powerManagement.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
    };
  };

  services = {
    desktopManager.plasma6.enable = true;
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
    };
    xserver = {
      enable = true;
      xkb = {
        variant = "";
        layout = "us,fi";
        options = "grp:win_space_toggle";
      };
      videoDrivers = [ "nvidia" ];
    };

    dbus.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  security.rtkit.enable = true;
  virtualisation.docker.enable = true;

  fonts.packages = with pkgs; [ nerd-fonts.iosevka maple-mono-NF ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };
}
