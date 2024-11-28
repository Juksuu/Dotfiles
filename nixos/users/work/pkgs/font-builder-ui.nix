{ stdenv, pkgs, fetchzip, steam-run, makeWrapper }:
stdenv.mkDerivation (finalAttrs: {
  pname = "font-builder-ui";
  version = "2.1.3";
  apila-version = "27.0.3";

  src = fetchzip {
    url =
      "http://developer.sw.veikkaus.fi/fsbuilderui/FontBuilderUI-linux-x64-${finalAttrs.version}_${finalAttrs.apila-version}.zip";
    hash = "sha256-D6RtbSBM8AmUyMMvhM8t80nuOUWp2NcU1Om1Q8UScj0=";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin $out/opt/font-builder-ui
    mv * $out/opt/font-builder-ui

    # Run the binary with steam-run for now
    makeWrapper ${steam-run}/bin/steam-run $out/bin/FontBuilderUI --add-flags $out/opt/font-builder-ui/FontBuilderUI
    # ln -s $out/opt/font-builder-ui/FontBuilderUI $out/bin/FontBuilderUI
  '';
})

