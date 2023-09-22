{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  system.stateVersion = "23.05";

  nix.settings = {
    auto-optimise-store = true;
    experimental-features = "nix-command flakes";
    substituters = [ "https://hyprland.cachix.org" ];
    trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIMBioiJM7ypFP8PwtkuGc=" ];
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
  networking.hostName = "homenix";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Helsinki";
  time.hardwareClockInLocalTime = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
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

  environment.systemPackages = with pkgs; [
    jq
    gcc
    vim
    fish
    htop
    alsa-utils
    pavucontrol
    home-manager

    # Wayland stuff
    grim
    slurp
    eww-wayland
    egl-wayland
    wl-clipboard
    qt5.qtwayland
    qt6.qtwayland

    # Hyrpland stuff
    socat
    hyprpaper
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    XDG_SESSION_TYPE = "wayland";
    WLR_NO_HARDWARE_CURSORS = "1";

    # Nvidia specific
    LIBVA_DRIVER_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";

    # QT Variables
    QT_QPA_PLATFORM = "wayland;xcb";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";

    GDK_BACKEND = "wayland,x11";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
  };

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
    nvidia = {
      open = true;
      modesetting.enable = true;
      powerManagement.enable = true;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
    };
  };

  services.xserver = {
    enable = true;
    layout = "us,fi";
    xkbVariant = "";
    xkbOptions = "grp:win_space_toggle";
    videoDrivers = [ "nvidia" ];
    displayManager.gdm.enable = true;
  };

  services.dbus.enable = true;

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  environment.etc =
    let
      json = pkgs.formats.json { };
    in
    {
      "wireplumber/main.lua.d/99-alsa-lowlatency.lua".text = ''
        alsa_monitor.rules = {
          {
            matches = {{{ "node.name", "matches", "alsa_output.*" }}};
            apply_properties = {
              ["audio.format"] = "S32LE",
              ["audio.rate"] = "96000", -- for USB soundcards it should be twice your desired rate
              ["api.alsa.period-size"] = 2, -- defaults to 1024, tweak by trial-and-error
              -- ["api.alsa.disable-batch"] = true, -- generally, USB soundcards use the batch mode
            },
          },
        }
      '';

      "pipewire/pipewire.conf.d/92-low-latency.conf".text = ''
        context.properties = {
          default.clock.rate = 48000
            default.clock.quantum = 256
            default.clock.min-quantum = 256
            default.clock.max-quantum = 256
        }
      '';

      "pipewire/pipewire-pulse.d/92-low-latency.conf".source = json.generate "92-low-latency.conf" {
        context.modules = [
          {
            name = "libpipewire-module-protocol-pulse";
            args = {
              pulse.min.req = "256/48000";
              pulse.default.req = "256/48000";
              pulse.max.req = "256/48000";
              pulse.min.quantum = "256/48000";
              pulse.max.quantum = "256/48000";
            };
          }
        ];
        stream.properties = {
          node.latency = "256/48000";
          resample.quality = 1;
        };
      };
    };

  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = [ "Iosevka" ];
    })
  ];

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    enableNvidiaPatches = true;
  };
}
