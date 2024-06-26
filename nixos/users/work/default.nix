{ pkgs, ... }: {
  users.users.work = {
    isNormalUser = true;
    home = "/home/work";
    description = "Work";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
