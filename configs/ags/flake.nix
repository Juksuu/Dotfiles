{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixpkgs-unstable";

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ags, }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      devShells.${system} = {
        default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nodePackages.typescript-language-server
            prettierd
            nodejs_23
          ];
        };
      };
    };
}
