{ stdenv, pkgs, fetchzip, steam-run, makeWrapper, lib }:
stdenv.mkDerivation (finalAttrs: {
  pname = "particle-editor";
  version = "5.1.3";

  src = fetchzip {
    url =
      "http://developer.sw.veikkaus.fi/particle-editor/ParticleEditor-linux-x64-${finalAttrs.version}.zip";
    hash = "sha256-q7Z+ukqBc/S43KI2yJlwbn4jquwAH0Ih8EkEfgj4rp4=";
  };

  buildInputs = [ pkgs.nss ];

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin $out/opt/particle-editor
    mv * $out/opt/particle-editor

    # Run the binary with steam-run for now
    makeWrapper ${steam-run}/bin/steam-run $out/bin/ParticleEditor \
    --add-flags $out/opt/particle-editor/ParticleEditor \
    --set LD_LIBRARY_PATH ${lib.makeLibraryPath [ pkgs.nss pkgs.nspr ]}
  '';
})
