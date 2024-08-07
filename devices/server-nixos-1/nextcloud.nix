{ pkgs, ... }: {

  # imports = [ ./nextcloud-module.nix ];
  # disabledModules = [ "services/web-apps/nextcloud.nix" ];
  services.nextcloud = {
    enable = true;
    configureRedis = true;
    package = pkgs.nextcloud29;
    hostName = "nwright.cloud";
    datadir = "/vault/datastorage/nextcloud-data";
    config = {
      dbtype = "pgsql";
      dbuser = "nextcloud";
      dbhost = "/run/postgresql"; # nextcloud will add /.s.PGSQL.5432 by itself
      dbname = "nextcloud";
      adminpassFile = "/etc/nixos/password.txt";
      adminuser = "root";
    };
    settings = {
      trusted_proxies = [ "127.0.0.1" ];
      trusted_domains = [ "nwright.cloud" ];
      overwriteprotocol = "https";
      default_phone_region = "US";
    };
    # nginx.enableFastcgiRequestBuffering = true;
  };

  services.postgresql = {
    enable = true;
    dataDir = "/vault/datastorage/postgres";
    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [{
      name = "nextcloud";
      ensureDBOwnership = true;
    }];
  };

  # ensure that postgres is running *before* running the setup
  systemd.services."nextcloud-setup" = {
    requires = [ "postgresql.service" ];
    after = [ "postgresql.service" ];
  };

  services.nginx.virtualHosts."nwright.cloud" = {
    listen = [{
      addr = "127.0.0.1";
      port = 8009;
    }];
  };
}
