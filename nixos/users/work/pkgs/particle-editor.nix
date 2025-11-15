{ stdenv, pkgs, fetchzip, lib }:
stdenv.mkDerivation rec {
  pname = "particle-editor";
  version = "5.3.0";

  src = fetchzip {
    url =
      "http://developer.sw.veikkaus.fi/particle-editor/ParticleEditor-linux-x64-${version}.zip";
    hash = "sha256-MgQqZuMyezhMQY1CUi5oGGZ7ahmmvS2W2H40dp/Ep4c=";
  };

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    makeWrapper
    wrapGAppsHook3
  ];

  buildInputs = with pkgs; [ nss libdrm libgbm alsa-lib udev ];

  installPhase = ''
    mkdir -p $out/bin $out/opt/particle-editor
    mv * $out/opt/particle-editor

    # Remove prepackaged magick to use system magick instead
    rm -rf $out/opt/particle-editor/resources/app/assets/magick
  '';

  postFixup = ''
    makeWrapper $out/opt/particle-editor/ParticleEditor $out/bin/ParticleEditor \
    --prefix LD_LIBRARY_PATH : ${
      lib.makeLibraryPath buildInputs
    }:$out/opt/particle-editor \
    --add-flag --ozone-platform-hint=x11
  '';
}
