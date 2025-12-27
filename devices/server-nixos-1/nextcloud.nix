{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    "${
      fetchTarball {
        url = "https://github.com/onny/nixos-nextcloud-testumgebung/archive/fa6f062830b4bc3cedb9694c1dbf01d5fdf775ac.tar.gz";
        sha256 = "0gzd0276b8da3ykapgqks2zhsqdv4jjvbv97dsxg0hgrhb74z0fs";
      }
    }/nextcloud-extras.nix"
  ];
  services = {
    nextcloud = {
      enable = true;
      configureRedis = true;
      package = pkgs.nextcloud32;
      hostName = "nwright.cloud";
      webserver = "caddy";
      https = true;
      datadir = "/vault/services/nextcloud-data";
      config = {
        dbtype = "pgsql";
        dbuser = "nextcloud";
        dbhost = "/run/postgresql"; # nextcloud will add /.s.PGSQL.5432 by itself
        dbname = "nextcloud";
        adminpassFile = "/var/lib/secrets/nextcloud-adminpass.txt";
        adminuser = "root";
      };
      settings = {
        maintenance_window_start = 5;
        trusted_proxies = [ "127.0.0.1" ];
        trusted_domains = [ "nwright.cloud" ];
        overwriteprotocol = "https";
        default_phone_region = "US";
        allow_local_remote_servers = true;

        "memories.exiftool" = "${lib.getExe pkgs.exiftool}";
        "memories.vod.ffmpeg" = "${lib.getExe pkgs.ffmpeg-headless}";
        "memories.vod.ffprobe" = "${pkgs.ffmpeg-headless}/bin/ffprobe";
        preview_ffmpeg_path = "${pkgs.ffmpeg-headless}/bin/ffmpeg";
      };
    };

    postgresql = {
      enable = true;
      dataDir = "/vault/services/postgres";
      ensureDatabases = [ "nextcloud" ];
      ensureUsers = [
        {
          name = "nextcloud";
          ensureDBOwnership = true;
        }
      ];
    };
  };

  # ensure that postgres is running *before* running the setup
  systemd.services."nextcloud-setup" = {
    requires = [ "postgresql.service" ];
    after = [ "postgresql.service" ];
  };

  systemd.services."phpfpm-nextcloud".postStart = ''
    ${config.services.nextcloud.occ}/bin/nextcloud-occ config:app:set recognize node_binary --value '${lib.getExe pkgs.nodejs_20}'
  '';

  systemd.services.nextcloud-cron = {
    path = [ pkgs.perl ];
  };

}
