{ inputs, config, pkgs, ... }:
{
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "nathanwrightbusiness@gmail.com";
  security.acme.certs."nwright.cloud" = {
    dnsProvider = "cloudflare";
    credentialsFile = "/var/lib/secrets/cloudflare";
    extraDomainNames = [ "*.nwright.cloud" "*.nwright.tech" ];
  };
  services.caddy = {
    enable = true;
    user = "root";
    group = "root";

    virtualHosts = {
      "collabora.nwright.cloud" = {
        useACMEHost = "nwright.cloud";
        extraConfig = ''
          encode gzip
          reverse_proxy 127.0.0.1:9980
        '';
      };
      "onlyoffice.nwright.cloud" = {
        useACMEHost = "nwright.cloud";
        extraConfig = ''
            reverse_proxy localhost:8015
          '';
      };

      "nwright.cloud" = {
        useACMEHost = "nwright.cloud";
        extraConfig = ''
          redir /.well-known/carddav /remote.php/dav 301
          redir /.well-known/caldav /remote.php/dav 301
          redir /.well-known/webfinger /index.php/.well-known/webfinger 301
          redir /.well-known/nodeinfo /index.php/.well-known/nodeinfo 301

          encode gzip
          reverse_proxy localhost:8009
        '';
      };

      "photos.nwright.cloud" = {
        useACMEHost = "nwright.cloud";
        extraConfig = ''
          encode gzip
          reverse_proxy 127.0.0.1:2343
        '';
      };

      "penpot.nwright.cloud" = {
        useACMEHost = "nwright.cloud";
        extraConfig = ''
          encode gzip
          reverse_proxy localhost:8010
        '';
      };

      "it-tools.nwright.cloud" = {
        useACMEHost = "nwright.cloud";
        extraConfig = ''
          reverse_proxy localhost:8011
        '';
      };
      "matrix-admin.nwright.cloud" = {
        useACMEHost = "nwright.cloud";
        extraConfig = ''
          reverse_proxy localhost:8012
        '';
      };

      "car.nwright.cloud" = {
        useACMEHost = "nwright.cloud";
        extraConfig = ''
          reverse_proxy localhost:8014
        '';
      };

      "latex.nwright.cloud" = {
        useACMEHost = "nwright.cloud";
        extraConfig = ''
          reverse_proxy localhost:8016
        '';
      };


    };
  };
  services.nginx.virtualHosts."blog" = {
    forceSSL = false;
    enableACME = false;
    listen = [{ port = 8013; addr = "0.0.0.0"; ssl = false; }];
    root = pkgs.nwright-hugo-website;
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
