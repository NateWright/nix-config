{ config, pkgs, ... }:

{
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [ 
	virt-manager	
 ];

  # enable the docker service
  virtualisation.docker.enable = true;

  users.users.nwright.extraGroups = [ "docker" ];
}
