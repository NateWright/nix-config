{ pkgs, ... }: {
  services = {
    nextcloud = {
      enable = true;
      configureRedis = true;
      package = pkgs.nextcloud30;
      hostName = "nwright.cloud";
      datadir = "/vault/datastorage/nextcloud-data";
      config = {
        dbtype = "pgsql";
        dbuser = "nextcloud";
        dbhost =
          "/run/postgresql"; # nextcloud will add /.s.PGSQL.5432 by itself
        dbname = "nextcloud";
        adminpassFile = "/etc/nixos/password.txt";
        adminuser = "root";
      };
      settings = {
        maintenance_window_start = 5;
        trusted_proxies = [ "127.0.0.1" ];
        trusted_domains = [ "nwright.cloud" ];
        overwriteprotocol = "https";
        default_phone_region = "US";
      };
    };

    postgresql = {
      enable = true;
      dataDir = "/vault/datastorage/postgres";
      ensureDatabases = [ "nextcloud" ];
      ensureUsers = [{
        name = "nextcloud";
        ensureDBOwnership = true;
      }];
    };

    nginx.virtualHosts."nwright.cloud" = {
      listen = [{
        addr = "127.0.0.1";
        port = 8009;
      }];
    };
  };

  # ensure that postgres is running *before* running the setup
  systemd.services."nextcloud-setup" = {
    requires = [ "postgresql.service" ];
    after = [ "postgresql.service" ];
  };

}
