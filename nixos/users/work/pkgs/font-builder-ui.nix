{ stdenv, pkgs, fetchzip, steam-run, makeWrapper, lib }:
stdenv.mkDerivation (finalAttrs: {
  pname = "font-builder-ui";
  version = "2.1.3";
  apila-version = "27.0.3";

  src = fetchzip {
    url =
      "http://developer.sw.veikkaus.fi/fsbuilderui/FontBuilderUI-linux-x64-${finalAttrs.version}_${finalAttrs.apila-version}.zip";
    hash = "sha256-D6RtbSBM8AmUyMMvhM8t80nuOUWp2NcU1Om1Q8UScj0=";
  };

  buildInputs = [ pkgs.udev ];

  preFixup = let
    # we prepare our library path in the let clause to avoid it become part of the input of mkDerivation
    libPath = lib.makeLibraryPath [
      pkgs.glib
      pkgs.nss
      pkgs.nspr
      pkgs.dbus
      pkgs.at-spi2-atk
      pkgs.cups
      pkgs.libdrm
      pkgs.gtk3
      pkgs.pango
      pkgs.cairo
      pkgs.xorg.libX11
      pkgs.xorg.libXcomposite
      pkgs.xorg.libXdamage
      pkgs.xorg.libXext
      pkgs.xorg.libXfixes
      pkgs.xorg.libXrandr
      pkgs.xorg.libxcb
      pkgs.libxkbcommon
      pkgs.libgbm
      pkgs.expat
      pkgs.alsa-lib
    ];
  in ''
    patchelf \
      --set-interpreter "$(cat $NIX_CC/nix-support/dynamic-linker)" \
      --set-rpath "${libPath}:$out/opt/font-builder-ui/" \
      $out/opt/font-builder-ui/FontBuilderUI
  '';

  installPhase = ''
    mkdir -p $out/bin $out/opt/font-builder-ui
    mv * $out/opt/font-builder-ui

    ln -s ${pkgs.udev}/lib/libudev.so $out/opt/font-builder-ui/libudev.so.0

    # symlink the binary to bin/
    ln -s $out/opt/font-builder-ui/FontBuilderUI $out/bin/FontBuilderUI
  '';
})

