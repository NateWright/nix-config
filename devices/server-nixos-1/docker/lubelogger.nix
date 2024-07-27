{ ... }: {
  virtualisation.oci-containers = {
    containers = {
      lubelogger = {
        image = "ghcr.io/hargata/lubelogger:latest";
        volumes = [
          "/vault/containers/lubelog/config:/App/config"
          "/vault/containers/lubelog/data:/App/data"
          "/vault/containers/lubelog/documents:/App/wwwroot/documents"
          "/vault/containers/lubelog/images:/App/wwwroot/images"
          "/vault/containers/lubelog/temp:/App/wwwroot/temp"
          "/vault/containers/lubelog/log:/App/log"
          "/vault/containers/lubelog/keys:/root/.aspnet/DataProtection-Key"
        ];
        ports = [ "8014:8080" ];
        environmentFiles = [ /vault/containers/lubelog/.env ];
      };
    };
  };
}
