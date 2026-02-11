{
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  system.stateVersion = "24.05";

  imports = [ inputs.niri.nixosModules.niri ];

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
      # Use custom patch for kernel 6.19 for now until it is added to nixpkgs
      # package = config.boot.kernelPackages.nvidiaPackages.beta;
      package = config.boot.kernelPackages.nvidiaPackages.mkDriver {
        version = "590.48.01";
        sha256_64bit = "sha256-ueL4BpN4FDHMh/TNKRCeEz3Oy1ClDWto1LO/LWlr1ok=";
        sha256_aarch64 = "sha256-FOz7f6pW1NGM2f74kbP6LbNijxKj5ZtZ08bm0aC+/YA=";
        openSha256 = "sha256-hECHfguzwduEfPo5pCDjWE/MjtRDhINVr4b1awFdP44=";
        settingsSha256 = "sha256-NWsqUciPa4f1ZX6f0By3yScz3pqKJV1ei9GvOF8qIEE=";
        persistencedSha256 = "sha256-wsNeuw7IaY6Qc/i/AzT/4N82lPjkwfrhxidKWUtcwW8=";
        patchesOpen =
          let
            kernelPatch = pkgs.fetchpatch {
              url = "https://raw.githubusercontent.com/CachyOS/CachyOS-PKGBUILDS/refs/heads/master/nvidia/nvidia-utils/kernel-6.19.patch";
              hash = "sha256-YuJjSUXE6jYSuZySYGnWSNG5sfVei7vvxDcHx3K+IN4=";
            };
          in
          [
            kernelPatch
          ];
      };
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

  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };

  environment = {
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "auto";

      # Nvidia specific
      NVD_BACKEND = "direct";
      LIBVA_DRIVER_NAME = "nvidia";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";

      # Qt
      QT_QPA_PLATFORM = "wayland";
      QT_QPA_PLATFORMTHEME = "qt6ct";
      QT_QPA_PLATFORMTHEME_QT6 = "qt6ct";
    };

    systemPackages = with pkgs; [
      jq
      gcc
      vim
      fzf
      htop
      greetd
      libnotify
      alsa-utils
      pavucontrol
      home-manager
      kdePackages.qtmultimedia

      # Terminal (alacritty used in most setups as default)
      alacritty

      # Wayland
      wl-clipboard
      cliphist
      qt5.qtwayland
      qt6.qtwayland
      xwayland-satellite

      # Programming
      codespell
      lazydocker
      docker-compose
      python3

      # Tools
      kdePackages.ark
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

  systemd.user.services.niri-flake-polkit.enable = false;
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable.overrideAttrs (
      finalAttrs: previousAttrs: {
        preInstall = ''
          echo "org.freedesktop.impl.portal.FileChooser=gtk;" >> "resources/niri-portals.conf"
        '';
      }
    );
  };

  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-dropbox-plugin
      thunar-archive-plugin
      thunar-volman
    ];
  };
}
