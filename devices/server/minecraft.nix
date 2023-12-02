{ config, pkgs, unstable, ...}:
{
  services.minecraft-server = {
    enable = true;
    eula = true;
    package = unstable.minecraft-server;
  };
}
