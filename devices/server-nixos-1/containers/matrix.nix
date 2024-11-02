{ ... }:
{
  containers.matrix = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";
    forwardPorts = [
      {
        containerPort = 8008;
        hostPort = 8008;
      }
      {
        containerPort = 8015;
        hostPort = 8015;
      }
    ];
    bindMounts = {
      config = {
        hostPath = "/vault/datastorage/matrix/config";
        mountPoint = "/var/lib/matrix-synapse";
        isReadOnly = false;
      };
      storage = {
        hostPath = "/vault/datastorage/matrix";
        mountPoint = "/vault/datastorage/matrix";
        isReadOnly = false;
      };
    };
    config =
      {
        config,
        pkgs,
        lib,
        ...
      }:
      {

        services = {
          matrix-synapse = {
            enable = true;
            settings = {
              server_name = "nwright.tech";
              public_baseurl = "https://nwright.tech:8448/";
              listeners = [
                {
                  port = 8008;
                  bind_addresses = [ "::" ];
                  type = "http";
                  tls = false;
                  x_forwarded = true;
                  resources = [
                    {
                      names = [
                        "client"
                        "federation"
                      ];
                      compress = true;
                    }
                  ];
                }
              ];
            };
            extraConfigFiles = [
              "/vault/datastorage/matrix/secrets/join-code.txt"
              (pkgs.writeText "matrix-synapse_extraConfigs" ''
                extra_well_known_client_content:
                  "org.matrix.msc3575.proxy":
                    "url": "https://sliding-sync.nwright.tech"
              '')
            ];
          };

          matrix-sliding-sync = {
            enable = true;
            environmentFile = "/vault/datastorage/matrix/secrets/sliding-sync-env";
            settings = {
              SYNCV3_SERVER = "https://nwright.tech:443";
              SYNCV3_BINDADDR = "[::]:8015";
            };
          };

          postgresql = {
            enable = true;
            dataDir = "/vault/datastorage/matrix/postgres";
            ensureDatabases = [ "matrix-synapse" ];
            ensureUsers = [
              {
                name = "matrix-synapse";
                ensureDBOwnership = true;
                ensureClauses = {
                  login = true;
                };
              }
            ];
          };

          resolved.enable = true;
        };

        # ensure that postgres is running *before* running the setup
        systemd.services."matrix-synapse" = {
          requires = [ "postgresql.service" ];
          after = [ "postgresql.service" ];
        };

        networking = {
          firewall = {
            enable = true;
            allowedTCPPorts = [
              8008
              8015
            ];
          };
          # Use systemd-resolved inside the container
          # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
          useHostResolvConf = lib.mkForce false;
        };

        system.stateVersion = "23.11";
      };
  };
}
