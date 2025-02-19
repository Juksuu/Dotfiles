{ pkgs, ... }: {
  users.users.frans = {
    isNormalUser = true;
    home = "/home/frans";
    description = "Frans";
    extraGroups = [ "networkmanager" "wheel" "docker" "video" "input" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
