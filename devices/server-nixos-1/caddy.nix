{
  pkgs,
  ...
}:
{
  systemd.services.caddy.serviceConfig.EnvironmentFile = [ "/var/lib/secrets/cloudflare" ];
  services.caddy = {
    enable = true;

    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.2.2" ];
      hash = "sha256-SrAHzXhaT3XO3jypulUvlVHq8oiLVYmH3ibh3W3aXAs=";
    };

    globalConfig = ''
      acme_dns cloudflare {
        zone_token {$CLOUDFLARE_ZONE_API_TOKEN}        
        api_token {$CLOUDFLARE_DNS_API_TOKEN}
      }
    '';
    virtualHosts = {

      "it-tools.nwright.cloud" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:8011
        '';
      };
      "matrix-admin.nwright.cloud" = {
        extraConfig = ''
          root * ${pkgs.synapse-admin};
        '';
      };

      "car.nwright.cloud" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:8014
        '';
      };

      "latex.nwright.cloud" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:8016
        '';
      };

      "collabora.nwright.cloud" = {
        extraConfig = ''
          encode gzip
          reverse_proxy 127.0.0.1:8017
        '';
      };
      "mealie.nwright.cloud" = {
        extraConfig = ''
          encode gzip
          reverse_proxy 100.126.55.82:9000
        '';
      };
      "neko.nwright.cloud" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:8019
        '';
      };
      # "cockpit.nwright.cloud" = {
      #   extraConfig = ''
      #     reverse_proxy 127.0.0.1:8021
      #   '';
      # };
      "auth.nwright.cloud" = {
        extraConfig = ''
          reverse_proxy 192.168.102.11:9000
        '';
      };
      "photos.nwright.cloud" = {
        extraConfig = ''
          reverse_proxy 100.91.45.126:2283
        '';
      };
      "docmost.nwright.cloud" = {
        extraConfig = ''
          reverse_proxy 100.121.152.117:3000
        '';
      };
      "budget.nwright.cloud" = {
        extraConfig = ''
          reverse_proxy 100.82.103.107:5006
        '';
      };
    };
  };
}
