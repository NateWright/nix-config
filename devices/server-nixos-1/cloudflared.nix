{ config, pkgs, ... }: {
  services.cloudflared = {
    enable = true;
    tunnels = {
      "nwright-nixos-server" = {
        credentialsFile =
          "/var/lib/secrets/76e0b21a-ea85-4d0a-87f5-cdabcd313e19.json";
        default = "http_status:404";
        # originRequest.originServerName = "latex.nwright.tech";
        originRequest.noTLSVerify = true;
        ingress = {
          "latex.nwright.tech" = "http://localhost:8016";
          # "matrix.nwright.tech/_matrix" = "http://localhost:8008";
          # "matrix.nwright.tech:8448/_matrix" = "http://localhost:8008";
          # "matrix.nwright.tech:8448/_synapse/client" = "http://localhost:8008";
        };
      };

    };
  };
}
