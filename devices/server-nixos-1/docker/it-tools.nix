{ ... }:
{
  virtualisation.oci-containers = {
    containers = {
      nix-it-tools = {
        image = "ghcr.io/corentinth/it-tools:latest";
        ports = [ "8011:80" ];
      };
    };
  };
}
