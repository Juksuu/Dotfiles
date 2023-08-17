{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, wrapGAppsHook
, gtk3
, librsvg
, libdbusmenu-gtk3
, gtk-layer-shell
, stdenv
}:

rustPlatform.buildRustPackage rec {
  pname = "eww";
  version = "systray-v3";

  src = fetchFromGitHub {
    owner = "ralismark";
    repo = "eww";
    rev = "aae214f51f4c8d8129cd0b8dbd0e1c362c50ce27";
    hash = "sha256-b/ipIavlmnEq4f1cQOrOCZRnIly3uXEgFbWiREKsh20=";
  };

  cargoHash = "sha256-YMYVy/ei2eCT62J480LWgg75eh+0SUoQuTU9far8YVs=";

  nativeBuildInputs = [ pkg-config wrapGAppsHook ];

  buildInputs = [ gtk3 librsvg gtk-layer-shell libdbusmenu-gtk3 ];

  buildNoDefaultFeatures = true;
  buildFeatures = [ "wayland" ];

  cargoBuildFlags = [ "--bin" "eww" ];

  cargoTestFlags = cargoBuildFlags;

  # requires unstable rust features
  RUSTC_BOOTSTRAP = 1;

  meta = with lib; {
    description = "ElKowars wacky widgets";
    homepage = "https://github.com/elkowar/eww";
    license = licenses.mit;
    maintainers = with maintainers; [ figsoda lom ];
    mainProgram = "eww";
    broken = stdenv.isDarwin;
  };
}
