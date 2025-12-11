{
  config,
  pkgs,
  ...
}:
let
  nextcloud-cfg = config.services.nextcloud;
  nextcloud-fpm = config.services.phpfpm.pools.nextcloud;
in
{
  systemd.services.caddy.serviceConfig.EnvironmentFile = [ "/var/lib/secrets/cloudflare" ];
  services.caddy = {
    enable = true;

    package = pkgs.caddy.withPlugins {
      plugins = [ "github.com/caddy-dns/cloudflare@v0.2.2" ];
      hash = "sha256-ea8PC/+SlPRdEVVF/I3c1CBprlVp1nrumKM5cMwJJ3U=";
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
      "cockpit.nwright.cloud" = {
        extraConfig = ''
          reverse_proxy 127.0.0.1:8021
        '';
      };
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
  services.nginx.virtualHosts."blog" = {
    forceSSL = false;
    enableACME = false;
    listen = [
      {
        port = 8013;
        addr = "0.0.0.0";
        ssl = false;
      }
    ];
    root = "/var/www/nwright.tech";
  };

  # services.nginx.virtualHosts."blog2" = {
  #   forceSSL = false;
  #   enableACME = false;
  #   sslCertificate = "/var/lib/secrets/host.cert";
  #   sslCertificateKey = "/var/lib/secrets/host.key";
  #   serverName = "t.nwright.tech";
  #   onlySSL = true;
  #   listen = [{ port = 8014; addr = "127.0.0.1"; ssl = true; }];
  #   root = pkgs.nwright-tech.nwright-hugo-website;
  # };

}
