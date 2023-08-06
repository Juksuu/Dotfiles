{ inputs, overlays }:
{
  makeSystem = { hostname, system, users }:
    let
      overlay-unstable = final: prev: {
        unstable = builtins.getAttr system inputs.nixpkgs-unstable.outputs.legacyPackages;
      };
    in
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system hostname; };
      modules = [
        inputs.hyprland.nixosModules.default
        {
          nixpkgs = {
            overlays = overlays ++ [ overlay-unstable ];
            config = {
              allowUnfree = true;
              allowUnfreePredicate = (_: true);
            };
          };
        }
        ./hosts/${hostname}
      ] ++ inputs.nixpkgs.lib.forEach users (u: ./users/${u});
    };

  makeHome = { system, username, hostname }:
    let
      overlay-unstable = final: prev: {
        unstable = builtins.getAttr system inputs.nixpkgs-unstable.outputs.legacyPackages;
      };
    in
    inputs.home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = { inherit system hostname inputs; };
      pkgs = builtins.getAttr system inputs.nixpkgs.outputs.legacyPackages;
      modules = [
        {
          nixpkgs = {
            overlays = overlays ++ [ overlay-unstable ];
            config = {
              allowUnfree = true;
              allowUnfreePredicate = (_: true);
            };
          };
          home = {
            inherit username;
            homeDirectory = "/home/${username}";
            stateVersion = "23.05";
          };
          systemd.user.startServices = "sd-switch";
        }
        ./users/${username}/home.nix
      ];
    };
}
