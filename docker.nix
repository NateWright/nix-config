{ config, pkgs, ... }:

{
  # make the docker command usable to users
  environment.systemPackages = with pkgs; [ 
	docker-compose
 ];

  # enable the docker service
  virtualisation.docker.enable = true;

  users.users.nwright.extraGroups = [ "docker" ];
}
