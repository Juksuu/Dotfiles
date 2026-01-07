{
  stdenv,
  pkgs,
  fetchzip,
  lib,
}:
stdenv.mkDerivation rec {
  pname = "SlotMachineSimulator";
  version = "1.7.1";

  src = fetchzip {
    url = "http://developer.sw.veikkaus.fi/smsimulator/SlotMachineSimulator-linux-x64-${version}.zip";
    hash = "sha256-gn4xLWx9QmbjEIoi08Bi+ZzPq7A2/8itRaMXHqG0MDE=";
  };

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    makeWrapper
    wrapGAppsHook3
  ];

  buildInputs = with pkgs; [
    nss
    libdrm
    libgbm
    alsa-lib
    udev
  ];

  installPhase = ''
    mkdir -p $out/bin $out/opt/slotmachine-simulator
    mv * $out/opt/slotmachine-simulator
  '';

  postFixup = ''
    makeWrapper $out/opt/slotmachine-simulator/SlotMachineSimulator $out/bin/SlotMachineSimulator \
      --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath buildInputs}:$out/opt/slotmachine-simulator
  '';
}
