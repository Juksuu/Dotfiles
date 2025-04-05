{
  description = "NixOS system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/master";
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

    hyprland.url = "github:hyprwm/Hyprland";
    ags.url = "github:aylur/ags";
  };

  outputs = inputs:
    let
      overlays = [
        inputs.neovim-overlay.overlays.default
        (final: prev:
          let
            zen-browser-unwrapped =
              inputs.zen-browser.packages.${prev.pkgs.system}.zen-browser-unwrapped.overrideAttrs
              (previousAttrs: {
                src = prev.fetchurl {
                  url =
                    "https://github.com/zen-browser/desktop/releases/download/1.11b/zen.linux-x86_64.tar.xz";
                  hash = "sha256-xAjzK6z6gSJ0iP7EvqzF5+sENU1o5Ud2syivAw8ivDs=";
                };
              });
          in {
            zen-browser =
              prev.wrapFirefox zen-browser-unwrapped { pname = "zen-browser"; };
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
