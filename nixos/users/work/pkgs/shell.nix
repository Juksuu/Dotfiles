{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  buildInputs = [
    (pkgs.callPackage ./font-builder-ui.nix { })
    (pkgs.callPackage ./particle-editor.nix { })
    (pkgs.callPackage ./slotmachine-simulator.nix { })
    (pkgs.callPackage ./font-style-editor.nix { })
  ];
}
