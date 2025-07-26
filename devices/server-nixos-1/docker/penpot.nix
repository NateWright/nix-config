# Auto-generated using compose2nix v0.2.2-pre.
{ pkgs, lib, ... }: {
  # Containers
  virtualisation.oci-containers.containers = {
    "penpot-penpot-backend" = {
      image = "penpotapp/backend:latest";
      environment = {
        "PENPOT_ASSETS_STORAGE_BACKEND" = "assets-fs";
        "PENPOT_DATABASE_PASSWORD" = "penpot";
        "PENPOT_DATABASE_URI" = "postgresql://penpot-postgres/penpot";
        "PENPOT_DATABASE_USERNAME" = "penpot";
        "PENPOT_FLAGS" =
          "enable-registration enable-login-with-password disable-email-verification enable-smtp enable-prepl-server";
        "PENPOT_PUBLIC_URI" = "https://penpot.nwright.cloud";
        "PENPOT_REDIS_URI" = "redis://penpot-redis/0";
        "PENPOT_SMTP_DEFAULT_FROM" = "no-reply@example.com";
        "PENPOT_SMTP_DEFAULT_REPLY_TO" = "no-reply@example.com";
        "PENPOT_SMTP_HOST" = "penpot-mailcatch";
        "PENPOT_SMTP_PASSWORD" = "";
        "PENPOT_SMTP_PORT" = "1025";
        "PENPOT_SMTP_SSL" = "false";
        "PENPOT_SMTP_TLS" = "false";
        "PENPOT_SMTP_USERNAME" = "";
        "PENPOT_STORAGE_ASSETS_FS_DIRECTORY" = "/opt/data/assets";
        "PENPOT_TELEMETRY_ENABLED" = "true";
      };
      volumes =
        [ "/vault/containers/penpot/penpot_penpot_assets:/opt/data/assets:rw" ];
      dependsOn = [ "penpot-penpot-postgres" "penpot-penpot-redis" ];
      log-driver = "journald";
      extraOptions =
        [ "--network-alias=penpot-backend" "--network=penpot_penpot" ];
    };
    "penpot-penpot-exporter" = {
      image = "penpotapp/exporter:latest";
      environment = {
        "PENPOT_PUBLIC_URI" = "http://penpot-frontend";
        "PENPOT_REDIS_URI" = "redis://penpot-redis/0";
      };
      log-driver = "journald";
      extraOptions =
        [ "--network-alias=penpot-exporter" "--network=penpot_penpot" ];
    };
    "penpot-penpot-frontend" = {
      image = "penpotapp/frontend:latest";
      environment = {
        "PENPOT_FLAGS" = "enable-registration enable-login-with-password";
      };
      volumes =
        [ "/vault/containers/penpot/penpot_penpot_assets:/opt/data/assets:rw" ];
      ports = [ "8010:80/tcp" ];
      dependsOn = [ "penpot-penpot-backend" "penpot-penpot-exporter" ];
      log-driver = "journald";
      extraOptions =
        [ "--network-alias=penpot-frontend" "--network=penpot_penpot" ];
    };
    "penpot-penpot-postgres" = {
      image = "postgres:15";
      environment = {
        "POSTGRES_DB" = "penpot";
        "POSTGRES_INITDB_ARGS" = "--data-checksums";
        "POSTGRES_PASSWORD" = "penpot";
        "POSTGRES_USER" = "penpot";
      };
      volumes = [
        "/vault/containers/penpot/penpot_penpot_postgres_v15:/var/lib/postgresql/data:rw"
      ];
      log-driver = "journald";
      extraOptions =
        [ "--network-alias=penpot-postgres" "--network=penpot_penpot" ];
    };
    "penpot-penpot-redis" = {
      image = "redis:7";
      log-driver = "journald";
      extraOptions =
        [ "--network-alias=penpot-redis" "--network=penpot_penpot" ];
    };
  };
  systemd.services."docker-penpot-penpot-backend" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
      RestartMaxDelaySec = lib.mkOverride 500 "1m";
      RestartSec = lib.mkOverride 500 "100ms";
      RestartSteps = lib.mkOverride 500 9;
    };
    after = [ "docker-network-penpot_penpot.service" ];
    requires = [ "docker-network-penpot_penpot.service" ];
  };
  systemd.services."docker-penpot-penpot-exporter" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
      RestartMaxDelaySec = lib.mkOverride 500 "1m";
      RestartSec = lib.mkOverride 500 "100ms";
      RestartSteps = lib.mkOverride 500 9;
    };
    after = [ "docker-network-penpot_penpot.service" ];
    requires = [ "docker-network-penpot_penpot.service" ];
  };
  systemd.services."docker-penpot-penpot-frontend" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
      RestartMaxDelaySec = lib.mkOverride 500 "1m";
      RestartSec = lib.mkOverride 500 "100ms";
      RestartSteps = lib.mkOverride 500 9;
    };
    after = [ "docker-network-penpot_penpot.service" ];
    requires = [ "docker-network-penpot_penpot.service" ];
  };
  systemd.services."docker-penpot-penpot-postgres" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
      RestartMaxDelaySec = lib.mkOverride 500 "1m";
      RestartSec = lib.mkOverride 500 "100ms";
      RestartSteps = lib.mkOverride 500 9;
    };
    after = [ "docker-network-penpot_penpot.service" ];
    requires = [ "docker-network-penpot_penpot.service" ];
  };
  systemd.services."docker-penpot-penpot-redis" = {
    serviceConfig = {
      Restart = lib.mkOverride 500 "always";
      RestartMaxDelaySec = lib.mkOverride 500 "1m";
      RestartSec = lib.mkOverride 500 "100ms";
      RestartSteps = lib.mkOverride 500 9;
    };
    after = [ "docker-network-penpot_penpot.service" ];
    requires = [ "docker-network-penpot_penpot.service" ];
  };

  # Networks
  systemd.services."docker-network-penpot_penpot" = {
    path = [ pkgs.docker ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStop = "docker network rm -f penpot_penpot";
    };
    script = ''
      docker network inspect penpot_penpot || docker network create penpot_penpot
    '';
    partOf = [ "docker-compose-penpot-root.target" ];
    wantedBy = [ "docker-compose-penpot-root.target" ];
  };

}
