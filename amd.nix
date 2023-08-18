{ config, lib, pkgs, ... }:
{
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = ["amdgpu"];
  hardware.opengl.driSupport = true;

}
