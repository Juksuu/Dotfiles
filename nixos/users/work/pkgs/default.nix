pkgs: {
  font-builder-ui = pkgs.callPackage ./font-builder-ui.nix { };
  particle-editor = pkgs.callPackage ./particle-editor.nix { };
  slotmachine-simulator = pkgs.callPackage ./slotmachine-simulator.nix { };
}
