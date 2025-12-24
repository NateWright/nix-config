{ ... }:
{

  # enable the docker service
  virtualisation = {
    docker = {
      enable = true;
      autoPrune.enable = true;
    };
  };

  virtualisation.oci-containers = {
    backend = "docker";
  };
}
