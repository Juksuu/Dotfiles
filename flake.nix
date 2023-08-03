{
  description = "NixOS system";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: 
    let
      utils = import ./nixos/utils.nix { inherit inputs; };
    in
    {
      nixosConfigurations = {
        frans = utils.makeSystem {
          system = "x86_64-linux";
          hostname = "homenix";
          users = [ "frans" ];
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
