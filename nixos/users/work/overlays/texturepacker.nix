{ final, prev }: {
  texturepacker = prev.texturepacker.overrideAttrs (previousAttrs: rec {
    version = "6.0.2";
    src = prev.fetchurl {
      url =
        "https://www.codeandweb.com/download/texturepacker/${version}/TexturePacker-${version}.deb";
      hash = "sha256-Ur45HLr1NK2NpCPKS0cYgwtNPZYogvEWUmw02JiCZv8=";
    };

    autoPatchelfIgnoreMissingDeps = true;

    installPhase = ''
      runHook preInstall
      mkdir -p $out/bin $out/lib/texturepacker
      cp -a usr/lib/texturepacker/. $out/lib/texturepacker/
      cp usr/bin/TexturePackerGUI $out/bin
      cp -r usr/share $out
      runHook postInstall
    '';

    postInstall = ''
      ln -s $out/lib/texturepacker/TexturePacker $out/bin/TexturePacker
    '';
  });
}
