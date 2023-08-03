{ pkgs, ...}:
{
  users.users.frans = {
    isNormalUser = true;
    home = "/home/frans";
    description = "Frans";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}
