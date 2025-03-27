{ inputs, lib, config, pkgs, ... }: {
  specialisation = {
    plasma6.configuration = {
      environment = {
        plasma6.excludePackages = with pkgs.kdePackages; [
          elisa
          okular
          oxygen
          khelpcenter
          print-manager
        ];
      };

      services.desktopManager.plasma6.enable = true;
    };
  };
}
