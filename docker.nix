{ config, pkgs, ... }:

{
  # make the docker command usable to users
  environment.systemPackages = with pkgs; [ 
	docker-compose
  podman-compose

 ];

  # enable the docker service
  virtualisation = {
    docker.enable = true;
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      # dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };
  # virtualisation.docker.daemon.settings = {
  #   "userland-proxy" = false;
  # };

  users.users.nwright.extraGroups = [ "docker" ];
}
