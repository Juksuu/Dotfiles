{ config, pkgs, unstable-pkgs, ...}:
{
  home.packages = with pkgs; [
    wofi
    brave
  ];

  programs.git = {
    enable = true;
    userName = "Frans Paasonen";
    userEmail = "franspaasonen@gmail.com";
  };
}
