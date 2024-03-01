{ inputs, lib, config, pkgs, ... }: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  system.stateVersion = "23.11";

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
    hostName = "homenix";
    networkmanager.enable = true;
  };

  # Set your time zone.
  time = {
    timeZone = "Europe/Helsinki";
    hardwareClockInLocalTime = true;
  };

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

      # Programming stuff
      python3
      codespell
      lazydocker
      docker-compose
    ];
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    nvidia = {
      modesetting.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };

  services = {
    xserver = {
      enable = true;
      xkb = {
        variant = "";
        layout = "us,fi";
        options = "grp:win_space_toggle";
      };
      videoDrivers = [ "nvidia" ];
      displayManager.sddm.enable = true;
      desktopManager.plasma6.enable = true;
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

  fonts.packages = with pkgs;
    [ (nerdfonts.override { fonts = [ "Iosevka" ]; }) ];

  programs.steam.enable = true;
}
