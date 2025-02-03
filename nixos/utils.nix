{ inputs, overlays }: {
  makeSystem = { hostname, system, users }:
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
        inputs.home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
      ] ++ inputs.nixpkgs.lib.forEach users (u: ./users/${u});
    };
}
