{ pkgs, ... }: {
  users.users.frans = {
    isNormalUser = true;
    home = "/home/frans";
    description = "Frans";
    extraGroups =
      [ "networkmanager" "wheel" "docker" "video" "input" "audio" "realtime" ];
    shell = pkgs.fish;
  };

  programs.fish.enable = true;
}
