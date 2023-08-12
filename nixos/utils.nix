{ inputs, overlays }:
{
  makeSystem = { hostname, system, users }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system hostname; };
      modules = [
        inputs.hyprland.nixosModules.default
        {
          nixpkgs = {
            inherit overlays;
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
    inputs.home-manager.lib.homeManagerConfiguration {
      extraSpecialArgs = { inherit system hostname inputs; };
      pkgs = builtins.getAttr system inputs.nixpkgs.outputs.legacyPackages;
      modules = [
        {
          nixpkgs = {
            inherit overlays;
            config = {
              allowUnfree = true;
              allowUnfreePredicate = (_: true);
            };
          };
          home = {
            inherit username;
            homeDirectory = "/home/${username}";
            stateVersion = "23.11";
          };
          systemd.user.startServices = "sd-switch";
        }
        ./users/${username}/home.nix
      ];
    };
}
