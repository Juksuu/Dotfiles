{ inputs, lib, config, pkgs, ... }: {
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
    graphics.extraPackages = [ pkgs.nvidia-vaapi-driver ];
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
    };

    displayManager.gdm.enable = true;

    dbus = {
      enable = true;
      implementation = "broker";
    };

    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      wireplumber.enable = true;
    };

    gvfs.enable = true;
    tumbler.enable = true;

    usbmuxd = {
      enable = true;
      package = pkgs.usbmuxd2;
    };
  };

  security.rtkit.enable = true;
  virtualisation.docker.enable = true;
  documentation.man.generateCaches = false;

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";

      # Nvidia specific
      NVD_BACKEND = "direct";
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";

      # Qt
      QT_QPA_PLATFORMTHEME = "qt6ct";
      QT_QPA_PLATFORMTHEME_QT6 = "qt6ct";
    };

    systemPackages = with pkgs; [
      jq
      gcc
      vim
      fzf
      fish
      htop
      libnotify
      alsa-utils
      pavucontrol
      home-manager
      xfce.thunar
      xarchiver
      kdePackages.qtmultimedia

      # Terminal (alacritty used in most setups as default)
      alacritty

      # Wayland
      wl-clipboard
      cliphist
      qt5.qtwayland
      qt6.qtwayland

      # Programming
      codespell
      lazydocker
      docker-compose

      # Tools
      libimobiledevice
      ifuse

      # Theming
      bibata-cursors
      oranchelo-icon-theme
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

  programs.nix-ld.enable = true;

  programs.dconf.enable = true;

  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };

  programs.thunar.plugins = with pkgs.xfce; [
    thunar-dropbox-plugin
    thunar-archive-plugin
    thunar-volman
  ];

  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart =
        "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
}
