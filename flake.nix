{
  description = "NixOS system";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.05";
    nixpkgs-master.url = "github:NixOS/nixpkgs/master";
    home-manager.url = "github:nix-community/home-manager/release-23.05";
    neovim-nightly.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = inputs:
    let
      masterOverlay = final: prev: {
        master = import inputs.nixpkgs-master {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
      };
      overlays = [ inputs.neovim-nightly.overlay masterOverlay ];
      utils = import ./nixos/utils.nix { inherit inputs overlays; };
    in {
      nixosConfigurations = {
        homenix = utils.makeSystem {
          system = "x86_64-linux";
          hostname = "homenix";
          users = [ "frans" ];
          extraModules = [ ];
        };
      };

      homeConfigurations = {
        "frans@homenix" = utils.makeHome {
          system = "x86_64-linux";
          username = "frans";
          hostname = "homenix";
        };
      };
    };
}
