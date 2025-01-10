{ stdenv, pkgs, fetchzip, steam-run, makeWrapper, lib }:
stdenv.mkDerivation (finalAttrs: {
  pname = "SlotMachineSimulator";
  version = "1.7.1";

  src = fetchzip {
    url =
      "http://developer.sw.veikkaus.fi/smsimulator/SlotMachineSimulator-linux-x64-${finalAttrs.version}.zip";
    hash = "sha256-gn4xLWx9QmbjEIoi08Bi+ZzPq7A2/8itRaMXHqG0MDE=";
  };

  buildInputs = [ pkgs.nss ];

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin $out/opt/slotmachine-simulator
    mv * $out/opt/slotmachine-simulator

    # Run the binary with steam-run for now
    makeWrapper ${steam-run}/bin/steam-run $out/bin/SlotMachineSimulator \
    --add-flags $out/opt/slotmachine-simulator/SlotMachineSimulator \
    --set LD_LIBRARY_PATH ${lib.makeLibraryPath [ pkgs.nss pkgs.nspr ]}
  '';
})
