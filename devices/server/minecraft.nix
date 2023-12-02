{ config, pkgs, ...}:
{
  services.minecraft-server = {
    enable = true;
    eula = true;
    package = pkgs.unstable.minecraft-server;
  };
}
