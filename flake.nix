{
  description = "NixOS system";

  inputs = {
    nixpkgs.url = "nixpkgs";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mac-app-util = {
      url = "github:hraban/mac-app-util";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake";
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    dgop = {
      url = "github:AvengeMedia/dgop";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dms-cli = {
      url = "github:AvengeMedia/danklinux";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dankMaterialShell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.dgop.follows = "dgop";
      inputs.dms-cli.follows = "dms-cli";
    };
  };

  outputs = inputs:
    let
      overlays = [
        inputs.neovim-overlay.overlays.default
        inputs.niri.overlays.niri
        (final: prev: {
          zen-browser =
            inputs.zen-browser.packages.${prev.pkgs.stdenv.hostPlatform.system}.default;
        })
        (final: prev: {
          quickshell =
            inputs.quickshell.packages.${prev.pkgs.stdenv.hostPlatform.system}.default;
        })
      ];
      utils = import ./nixos/utils.nix { inherit inputs overlays; };
      darwinUtils = import ./darwinNix/utils.nix { inherit inputs overlays; };
    in {
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

      darwinConfigurations = {
        juksumac = darwinUtils.makeSystem {
          system = "x86_64-darwin";
          hostname = "juksumac";
          users = [ "juksu" ];
        };
      };
    };
}
