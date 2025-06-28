{ stdenv, pkgs, fetchzip, steam-run, makeWrapper, lib }:
stdenv.mkDerivation (finalAttrs: {
  pname = "SlotMachineSimulator";
  version = "1.7.1";

  src = fetchzip {
    url =
      "http://developer.sw.veikkaus.fi/smsimulator/SlotMachineSimulator-linux-x64-${finalAttrs.version}.zip";
    hash = "sha256-gn4xLWx9QmbjEIoi08Bi+ZzPq7A2/8itRaMXHqG0MDE=";
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
      --set-rpath "${libPath}:$out/opt/slotmachine-simulator/" \
      $out/opt/slotmachine-simulator/SlotMachineSimulator
  '';

  installPhase = ''
    mkdir -p $out/bin $out/opt/slotmachine-simulator
    mv * $out/opt/slotmachine-simulator

    ln -s ${pkgs.udev}/lib/libudev.so $out/opt/slotmachine-simulator/libudev.so.0

    # symlink the binary to bin/
    ln -s $out/opt/slotmachine-simulator/SlotMachineSimulator $out/bin/SlotMachineSimulator
  '';
})
