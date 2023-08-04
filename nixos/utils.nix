{ inputs, overlays }:
{
  makeSystem = { hostname, system, users }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system hostname; };
      modules = [
        ./hosts/${hostname}
        {
          nixpkgs = {
            inherit overlays;
          };
        }
      ] ++ inputs.nixpkgs.lib.forEach users (u: ./users/${u});
    };

  makeHome = { system, username, hostname }:
    inputs.home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = {
        inherit system hostname inputs;
        unstable-pkgs = builtins.getAttr system inputs.nixpkgs-unstable.outputs.legacyPackages;
      };
      pkgs = builtins.getAttr system inputs.nixpkgs.outputs.legacyPackages;
      modules = [
        ./users/${username}/home.nix
        {
          systemd.user.startServices = "sd-switch";
          home = {
            inherit username;
            homeDirectory = "/home/${username}";
            stateVersion = "23.05";
          };
          nixpkgs = {
            inherit overlays;
          };
        }
      ];
    };
}
