{
  stdenv,
  pkgs,
  fetchzip,
  lib,
}:
stdenv.mkDerivation rec {
  pname = "FontStyleEditor";
  version = "1.0.2";

  src = fetchzip {
    url = "http://developer.sw.veikkaus.fi/fse/launcher/FontStyleEditor-linux-x64-${version}.zip";
    hash = "sha256-0hfdpZYryheevhU19HgrEFCvOAiJflrJUaOjVNqryHc=";
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

  autoPatchelfIgnoreMissingDeps = [
    "libsendfile.so"
    "libsocket.so"
  ];

  # avoid double-wrapping
  dontWrapGApps = true;

  installPhase = ''
    mkdir -p $out/bin $out/opt/font-style-editor
    mv * $out/opt/font-style-editor
  '';

  postFixup = ''
    makeWrapper $out/opt/font-style-editor/FontStyleEditor $out/bin/FontStyleEditor \
    --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath buildInputs}:$out/opt/font-style-editor \
    "''${gappsWrapperArgs[@]}"
  '';
}
