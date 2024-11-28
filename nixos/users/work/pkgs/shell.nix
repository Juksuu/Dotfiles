{ pkgs ? import <nixpkgs> { } }:

pkgs.mkShell {
  buildInputs = [
    (pkgs.callPackage ./font-builder-ui.nix { })
    (pkgs.callPackage ./particle-editor.nix { })
  ];
}
