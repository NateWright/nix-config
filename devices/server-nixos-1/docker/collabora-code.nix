{ ... }: {
  virtualisation.oci-containers = {
    containers = {
      collabora-code = {
        image = "collabora/code:latest";
        ports = [ "8017:9980" ];
        environment = {
          username = "admin";
          password = "secret";
          domain = "collabora.nwright.cloud";
          extra_params = "--o:ssl.enable=false --o:ssl.termination=true";
        };
      };
    };
  };
}
