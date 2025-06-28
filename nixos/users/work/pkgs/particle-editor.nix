{ stdenv, pkgs, fetchzip, steam-run, makeWrapper, lib }:
stdenv.mkDerivation (finalAttrs: {
  pname = "particle-editor";
  version = "5.3.0";

  src = fetchzip {
    url =
      "http://developer.sw.veikkaus.fi/particle-editor/ParticleEditor-linux-x64-${finalAttrs.version}.zip";
    hash = "sha256-MgQqZuMyezhMQY1CUi5oGGZ7ahmmvS2W2H40dp/Ep4c=";
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
      --set-rpath "${libPath}:$out/opt/particle-editor/" \
      $out/opt/particle-editor/ParticleEditor
  '';

  installPhase = ''
    mkdir -p $out/bin $out/opt/particle-editor
    mv * $out/opt/particle-editor

      ln -s ${pkgs.udev}/lib/libudev.so $out/opt/particle-editor/libudev.so.0

      # symlink the binary to bin/
      ln -s $out/opt/particle-editor/ParticleEditor $out/bin/ParticleEditor
  '';
})
