{ config, pkgs, ... }:
{
  services = {
    photoprism = {
      enable = true;
      port = 2343;
      originalsPath = "/var/lib/private/photoprism";
      address = "0.0.0.0";
      settings = {
        PHOTOPRISM_ADMIN_USER = "admin";
        PHOTOPRISM_ADMIN_PASSWORD = "initial-password";
        PHOTOPRISM_DEFAULT_LOCALE = "en";
        PHOTOPRISM_DATABASE_DRIVER = "mysql";
        PHOTOPRISM_DATABASE_NAME = "photoprism";
        PHOTOPRISM_DATABASE_SERVER = "/run/mysqld/mysqld.sock";
        PHOTOPRISM_DATABASE_USER = "photoprism";
        PHOTOPRISM_SITE_URL = "https://photos.nwright.cloud";
        PHOTOPRISM_SITE_TITLE = "My PhotoPrism";
      };
    };

    mysql = {
      enable = true;
      dataDir = "/vault/services/photoprism-db";
      package = pkgs.mariadb;
      ensureDatabases = [ "photoprism" ];
      ensureUsers = [
        {
          name = "photoprism";
          ensurePermissions = {
            "photoprism.*" = "ALL PRIVILEGES";
          };
        }
      ];
    };
  };

  fileSystems."/var/lib/private/photoprism" = {
    device = "/vault/services/photoprism-data";
    options = [ "bind" ];
  };
}
