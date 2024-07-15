{ pkgs, ... }: {

  services.matrix-synapse = {
    enable = true;
    settings.server_name = "nwright.tech";
    settings.public_baseurl = "https://nwright.tech:8448/";
    settings.listeners = [{
      port = 8008;
      bind_addresses = [ "::" ];
      type = "http";
      tls = false;
      x_forwarded = true;
      resources = [{
        names = [ "client" "federation" ];
        compress = true;
      }];
    }];
    extraConfigFiles = [ "/vault/datastorage/matrix/secrets/join-code.txt" ];
  };

  services.postgresql = {
    enable = true;
    dataDir = "/vault/datastorage/postgres";
    ensureDatabases = [ "matrix-synapse" ];
    ensureUsers = [{
      name = "matrix-synapse";
      ensureDBOwnership = true;
      ensureClauses = { login = true; };
    }];
  };

  # ensure that postgres is running *before* running the setup
  systemd.services."matrix-synapse" = {
    requires = [ "postgresql.service" ];
    after = [ "postgresql.service" ];
  };

}
