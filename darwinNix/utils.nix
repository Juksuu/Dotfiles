{ inputs, overlays }: {

  makeSystem = { hostname, system, users, extraModules }:
    inputs.darwin.lib.darwinSystem {
      inherit system;
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
        inputs.mac-app-util.darwinModules.default
        inputs.home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "backup";
          home-manager.sharedModules =
            [ inputs.mac-app-util.homeManagerModules.default ];
        }
        ./hosts/${hostname}
      ] ++ extraModules ++ inputs.nixpkgs.lib.forEach users (u: ./users/${u});
    };
}
