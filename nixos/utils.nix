{ inputs, overlays }: {
  makeSystem = { hostname, system, users, extraModules }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs system hostname; };
      modules = [
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
      ] ++ extraModules ++ inputs.nixpkgs.lib.forEach users (u: ./users/${u});
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
            stateVersion = "23.05";
          };
          systemd.user.startServices = "sd-switch";
        }
        ./users/${username}/home.nix
      ];
    };
}
