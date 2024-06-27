final: prev: {
  texturepacker = prev.texturepacker.overrideAttrs (previousAttrs: rec {
    version = "6.0.2";
    src = prev.fetchurl {
      url =
        "https://www.codeandweb.com/download/texturepacker/${version}/TexturePacker-${version}.deb";
      hash = "sha256-Ur45HLr1NK2NpCPKS0cYgwtNPZYogvEWUmw02JiCZv8=";
    };

    installPhase = ''
      mkdir -p $out/bin $out/lib
      cp usr/lib/texturepacker/{libGrantlee_Templates.so.5,libHQX.so.1.0.0,libPVRTexLib.so} $out/lib
      cp -a usr/lib/texturepacker/grantlee/. $out/bin/grantlee/
      cp usr/lib/texturepacker/TexturePacker $out/bin
      cp -r usr/share $out
    '';
  });
}
