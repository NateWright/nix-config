{ config, pkgs, ... }:
{
  services.nextcloud = {
    enable = true;
    hostName = "nix-nextcloud";
    config = {
      dbtype = "pgsql";
      dbuser = "nextcloud";
      dbhost = "/run/postgresql"; # nextcloud will add /.s.PGSQL.5432 by itself
      dbname = "nextcloud";
      adminpassFile = "/etc/nixos/password.txt";
      adminuser = "root";
    };
  };

  services.postgresql = {
    enable = true;
    dataDir = "/vault/datastorage/nextcloud";
    ensureDatabases = [ "nextcloud" ];
    ensureUsers = [
     { name = "nextcloud";
       ensurePermissions."DATABASE nextcloud" = "ALL PRIVILEGES";
     }
    ];
  };

  # services.onlyoffice = {
  #   enable = true;
  #   hostname = "nix-onlyoffice";
  #   port = 8000;
  # };

  # ensure that postgres is running *before* running the setup
  systemd.services."nextcloud-setup" = {
    requires = ["postgresql.service"];
    after = ["postgresql.service"];
  };

  services.nginx.virtualHosts."nix-nextcloud".listen = [ { addr = "127.0.0.1"; port = 8009; } ];
  # services.nginx.virtualHosts."nix-onlyoffice".listen = [ { addr = "127.0.0.1"; port = 9980; } ];

}