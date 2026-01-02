{ inputs, ... }: {
  additions = final: _prev: import ../pkgs final.pkgs;

  modifications = final: prev: {
    texturepacker =
      (import ./texturepacker.nix { inherit final prev; }).texturepacker;
  };
}
