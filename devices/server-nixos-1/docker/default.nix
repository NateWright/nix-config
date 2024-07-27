{ ... }: {

  # enable the docker service
  virtualisation = { docker.enable = true; };

  virtualisation.oci-containers = { backend = "docker"; };
}
