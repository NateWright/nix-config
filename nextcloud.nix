{ config, pkgs, ... }:
{
  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud25;
    hostName = "nix-nextcloud";
    datadir = "/vault/datastorage/nextcloud-data";
    config = {
      dbtype = "pgsql";
      dbuser = "nextcloud";
      dbhost = "/run/postgresql"; # nextcloud will add /.s.PGSQL.5432 by itself
      dbname = "nextcloud";
      adminpassFile = "/etc/nixos/password.txt";
      adminuser = "root";
      trustedProxies = [ "localhost" "127.0.0.1" "nixos.raptor-roach.ts.net" "100.93.196.119" "nix-nextcloud" ];
      extraTrustedDomains = [ "nixos.raptor-roach.ts.net" ];
      overwriteProtocol = "https";
    };
    extraOptions = {
      overwritewebroot = "/cloud";
    };
  };

  services.postgresql = {
    enable = true;
    dataDir = "/vault/datastorage/nextcloud-postgres";
    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [
     { name = "nextcloud";
       ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
     }
    ];
  };

  # ensure that postgres is running *before* running the setup
  systemd.services."nextcloud-setup" = {
    requires = ["postgresql.service"];
    after = ["postgresql.service"];
  };

  services.nginx.virtualHosts."nix-nextcloud".listen = [ { addr = "127.0.0.1"; port = 8009; } ];
  # services.nginx.virtualHosts."nix-onlyoffice".listen = [ { addr = "127.0.0.1"; port = 9980; } ];

}