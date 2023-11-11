{ config, pkgs, ... }:
{
  services.cloudflared = {
    enable = true;
    tunnels = {
      "nwright-nixos-server" = {
        credentialsFile = "/tmp/test";
        default = "http_status:404";
        ingress = {
          "*.nwright.tech" = {
            service = "http://localhost:80";
          };
        };
      };

    };
  };
}
