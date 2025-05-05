{ inputs, lib, config, pkgs, ... }: {
  system.stateVersion = "24.05";

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = "nix-command flakes";
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys =
      [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
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
  networking.networkmanager.enable = true;

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

  hardware = {
    nvidia = {
      open = true;
      modesetting.enable = true;
      powerManagement.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
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
      displayManager.lightdm.enable = false;
    };

    dbus = {
      enable = true;
      implementation = "broker";
    };

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    gvfs.enable = true;

    usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };
  };

  security.rtkit.enable = true;
  virtualisation.docker.enable = true;

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";

      # Nvidia specific
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";

      # Qt
      QT_QPA_PLATFORMTHEME = "qt6ct";
    };

    systemPackages = with pkgs; [
      jq
      gcc
      vim
      fzf
      fish
      htop
      uwsm
      sassc
      paprefs
      libnotify
      alsa-utils
      pavucontrol
      home-manager
      kdePackages.breeze-icons
      kdePackages.ark
      kdePackages.dolphin
      kdePackages.kde-cli-tools
      kdePackages.kcmutils
      kdePackages.kservice

      # Wayland
      wl-clipboard
      cliphist
      rofi-wayland
      qt5.qtwayland
      qt6.qtwayland

      # Programming
      codespell
      lazydocker
      docker-compose
      (python3.withPackages (ps: with ps; [ pywal colorthief ]))

      # Theming
      kdePackages.qtstyleplugin-kvantum
      kdePackages.qt6ct
      nwg-look

      # Tools
      libimobiledevice
      ifuse
    ];
  };

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    maple-mono.NF
    material-symbols
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
  };

  programs.hyprland = {
    enable = true;
    withUWSM = true;

    # set the flake package
    package =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # make sure to also set the portal package, so that they are in sync
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };
}
