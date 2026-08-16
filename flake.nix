{
  description = "NixOS system";

  inputs = {
    nixpkgs.url = "nixpkgs/master";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri = {
      url = "github:niri-wm/niri";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dank-material-shell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dank-greeter = {
      url = "github:AvengeMedia/dank-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    openconnect-pulse-launcher = {
      url = "github:erahhal/openconnect-pulse-launcher";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    claude-desktop.url = "github:aaddrick/claude-desktop-debian";
  };

  outputs =
    inputs:
    let
      overlays = [
        inputs.neovim-overlay.overlays.default
        inputs.niri.overlays.default
        inputs.claude-desktop.overlays.default
        inputs.quickshell.overlays.default
        (final: prev: {
          zen-browser =
            inputs.zen-browser.packages.${prev.pkgs.stdenv.hostPlatform.system}.default.overrideAttrs
              (previousAttrs: {
                buildInputs = (previousAttrs.buildInputs or [ ]) ++ [
                  prev.pkgs.libgbm
                ];
              });
        })
        (final: prev: {
          openconnect-pulse-launcher =
            inputs.openconnect-pulse-launcher.packages.${prev.pkgs.stdenv.hostPlatform.system}.openconnect-pulse-launcher;
        })
      ];
      utils = import ./nixos/utils.nix { inherit inputs overlays; };
    in
    {
      nixosConfigurations = {
        homenix = utils.makeSystem {
          system = "x86_64-linux";
          hostname = "homenix";
          users = [ "frans" ];
        };
        worknix = utils.makeSystem {
          system = "x86_64-linux";
          hostname = "worknix";
          users = [ "work" ];
        };
      };

      homeConfigurations = {
        "frans@homenix" = utils.makeHome {
          system = "x86_64-linux";
          username = "frans";
          hostname = "homenix";
        };
        "work@worknix" = utils.makeHome {
          system = "x86_64-linux";
          username = "work";
          hostname = "worknix";
        };
      };
    };
}
