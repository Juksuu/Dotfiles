{ inputs, overlays }: {
  makeSystem = { hostname, system, users }:
    inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs system hostname;
        pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
      };
      modules = [
        {
          nixpkgs = {
            inherit overlays;
            config = {
              allowUnfree = true;
              allowUnfreePredicate = (_: true);
            };
          };

          nix.settings.trusted-users = [ "root" "@wheel" ];
        }
        ./hosts/${hostname}
      ] ++ inputs.nixpkgs.lib.forEach users (u: ./users/${u});
    };

  makeHome = { system, username, hostname }:
    inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = builtins.getAttr system inputs.nixpkgs.outputs.legacyPackages;
      extraSpecialArgs = {
        inherit system hostname inputs;
        pkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${system};
      };
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
