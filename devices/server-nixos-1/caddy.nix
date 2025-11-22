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
  security.acme.acceptTerms = true;
  security.acme.defaults.email = "nathanwrightbusiness@gmail.com";
  security.acme.certs."nwright.cloud" = {
    dnsProvider = "cloudflare";
    credentialsFile = "/var/lib/secrets/cloudflare";
    extraDomainNames = [
      "*.nwright.cloud"
      "*.nwright.tech"
    ];
  };
  services.caddy = {
    enable = true;
    user = "root";
    group = "root";

    virtualHosts = {
      "nwright.cloud" = {
        useACMEHost = "nwright.cloud";
        extraConfig = ''
          encode zstd gzip

          root * ${config.services.nginx.virtualHosts.${nextcloud-cfg.hostName}.root}

          redir /.well-known/carddav /remote.php/dav 301
          redir /.well-known/caldav /remote.php/dav 301
          redir /.well-known/* /index.php{uri} 301
          redir /remote/* /remote.php{uri} 301

          header {
            Strict-Transport-Security max-age=31536000
            Permissions-Policy interest-cohort=()
            X-Content-Type-Options nosniff
            X-Frame-Options SAMEORIGIN
            Referrer-Policy no-referrer
            X-XSS-Protection "1; mode=block"
            X-Permitted-Cross-Domain-Policies none
            X-Robots-Tag "noindex, nofollow"
            -X-Powered-By
          }

          php_fastcgi unix/${nextcloud-fpm.socket} {
            root ${config.services.nginx.virtualHosts.${nextcloud-cfg.hostName}.root}
            env front_controller_active true
            env modHeadersAvailable true
          }

          @forbidden {
            path /build/* /tests/* /config/* /lib/* /3rdparty/* /templates/* /data/*
            path /.* /autotest* /occ* /issue* /indie* /db_* /console*
            not path /.well-known/*
          }
          error @forbidden 404

          @immutable {
            path *.css *.js *.mjs *.svg *.gif *.png *.jpg *.ico *.wasm *.tflite
            query v=*
          }
          header @immutable Cache-Control "max-age=15778463, immutable"

          @static {
            path *.css *.js *.mjs *.svg *.gif *.png *.jpg *.ico *.wasm *.tflite
            not query v=*
          }
          header @static Cache-Control "max-age=15778463"

          @woff2 path *.woff2
          header @woff2 Cache-Control "max-age=604800"

          file_server
        '';
      };

      # "penpot.nwright.cloud" = {
      #   useACMEHost = "nwright.cloud";
      #   extraConfig = ''
      #     encode gzip
      #     reverse_proxy 127.0.0.1:8010
      #   '';
      # };

      "it-tools.nwright.cloud" = {
        useACMEHost = "nwright.cloud";
        extraConfig = ''
          reverse_proxy 127.0.0.1:8011
        '';
      };
      "matrix-admin.nwright.cloud" = {
        useACMEHost = "nwright.cloud";
        extraConfig = ''
          root * ${pkgs.synapse-admin};
        '';
      };

      "car.nwright.cloud" = {
        useACMEHost = "nwright.cloud";
        extraConfig = ''
          reverse_proxy 127.0.0.1:8014
        '';
      };

      "latex.nwright.cloud" = {
        useACMEHost = "nwright.cloud";
        extraConfig = ''
          reverse_proxy 127.0.0.1:8016
        '';
      };

      "collabora.nwright.cloud" = {
        useACMEHost = "nwright.cloud";
        extraConfig = ''
          encode gzip
          reverse_proxy 127.0.0.1:8017
        '';
      };
      "mealie.nwright.cloud" = {
        useACMEHost = "nwright.cloud";
        extraConfig = ''
          encode gzip
          reverse_proxy 100.126.55.82:9000
        '';
      };
      "neko.nwright.cloud" = {
        useACMEHost = "nwright.cloud";
        extraConfig = ''
          reverse_proxy 127.0.0.1:8019
        '';
      };
      "cockpit.nwright.cloud" = {
        useACMEHost = "nwright.cloud";
        extraConfig = ''
          reverse_proxy 127.0.0.1:8021
        '';
      };
      "auth.nwright.cloud" = {
        useACMEHost = "nwright.cloud";
        extraConfig = ''
          reverse_proxy 192.168.102.11:9000
        '';
      };
      "photos.nwright.cloud" = {
        useACMEHost = "nwright.cloud";
        extraConfig = ''
          reverse_proxy 100.91.45.126:2283
        '';
      };
      "docmost.nwright.cloud" = {
        useACMEHost = "nwright.cloud";
        extraConfig = ''
          reverse_proxy 100.121.152.117:3000
        '';
      };
      "budget.nwright.cloud" = {
        useACMEHost = "nwright.cloud";
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
