{ config, pkgs, ... }:
{
  services.cloudflared = {
    enable = true;
    tunnels = {
      "nwright-nixos-server" = {
        credentialsFile = "/var/lib/secrets/c5351f78-1c7d-4de3-b41a-6ab3a901c8d2.json";
        default = "http_status:404";
        originRequest.originServerName = "t.nwright.tech";
        originRequest.noTLSVerify = true;
        ingress = {
          "t.nwright.tech" = "http://localhost:8013";
        };
      };

    };
  };
}
