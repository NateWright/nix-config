{ config, pkgs, ... }:
{
  services.cloudflared = {
    enable = true;
    tunnels = {
      # "nwright-nixos-server" = {
      #   credentialsFile = "/var/lib/secrets/c5351f78-1c7d-4de3-b41a-6ab3a901c8d2.json";
      #   default = "http_status:404";
      #   originRequest.originServerName = "t.nwright.tech";
      #   originRequest.noTLSVerify = true;
      #   ingress = {
      #     "t.nwright.tech" = "http://localhost:8016";
      #   };
      # };

      "nwright-nixos-server" = {
        credentialsFile = "/var/lib/secrets/1f795bd8-fba4-4372-961a-6b1ddb0af662.json";
        default = "http_status:404";
        originRequest.originServerName = "latex.nwright.tech";
        originRequest.noTLSVerify = true;
        ingress = {
          "latex.nwright.tech" = "http://localhost:8016";
        };
      };

    };
  };
}
