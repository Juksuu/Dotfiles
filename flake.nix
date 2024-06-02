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
  };

  outputs = inputs:
    let
      overlays = [ inputs.neovim-overlay.overlays.default ];
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
