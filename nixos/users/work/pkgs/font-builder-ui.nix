{ stdenv, pkgs, fetchzip, lib }:
stdenv.mkDerivation rec {
  pname = "font-builder-ui";
  version = "2.1.3";
  apila-version = "27.0.3";

  src = fetchzip {
    url =
      "http://developer.sw.veikkaus.fi/fsbuilderui/FontBuilderUI-linux-x64-${version}_${apila-version}.zip";
    hash = "sha256-D6RtbSBM8AmUyMMvhM8t80nuOUWp2NcU1Om1Q8UScj0=";
  };

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    makeWrapper
    wrapGAppsHook3
  ];

  buildInputs = with pkgs; [ nss libdrm libgbm alsa-lib udev ];

  installPhase = ''
    mkdir -p $out/bin $out/opt/font-builder-ui
    mv * $out/opt/font-builder-ui
  '';

  postFixup = ''
    makeWrapper $out/opt/font-builder-ui/FontBuilderUI $out/bin/FontBuilderUI \
      --prefix LD_LIBRARY_PATH : ${
        lib.makeLibraryPath buildInputs
      }:$out/opt/font-builder-ui
  '';
}
