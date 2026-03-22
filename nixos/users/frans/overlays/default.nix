{ inputs, ... }:
{
  additions = final: _prev: import ../pkgs final.pkgs;

  modifications = final: prev: {
    llama-cpp = (import ./llama-cpp.nix { inherit final prev; }).llama-cpp;
  };
}
