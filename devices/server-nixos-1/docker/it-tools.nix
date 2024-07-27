{ ... }: {
  virtualisation.oci-containers = {
    containers = {
      it-tools = {
        image = "ghcr.io/corentinth/it-tools:latest";
        ports = [ "8011:80" ];
      };
    };
  };
}
