{ inputs, ... }:
{
  containers.authentik = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.102.10";
    localAddress = "192.168.102.11";
    forwardPorts = [
      {
        containerPort = 9000;
        hostPort = 8020;
      }
    ];
    bindMounts = {
      storage = {
        hostPath = "/vault/datastorage/authentik";
        mountPoint = "/authentik";
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
        imports = [
          inputs.authentik-nix.nixosModules.default
        ];
        services = {
          authentik = {
            enable = true;
            environmentFile = "/authentik/env";
            settings = {
              email = {
                host = "smtp.example.com";
                port = 587;
                username = "authentik@example.com";
                use_tls = true;
                use_ssl = false;
                from = "authentik@example.com";
              };
              disable_startup_analytics = true;
              avatars = "initials";
            };
          };
        };

        networking = {
          firewall = {
            enable = true;
            allowedTCPPorts = [
              8020
              9000
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
