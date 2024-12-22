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

  makeDarwinSystem = { hostname, system, users, extraModules }:
    inputs.darwin.lib.darwinSystem {
      inherit system;
      modules = [
        inputs.home-manager.darwinModules.home-manager
        ./hosts/${hostname}
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.jdoe = import ./home.nix;
        }
      ] ++ extraModules ++ inputs.nixpkgs.lib.forEach users (u: ./users/darwin/${u});
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
          };
          systemd.user.startServices = "sd-switch";
        }
        ./users/${username}/home.nix
      ];
    };
}
