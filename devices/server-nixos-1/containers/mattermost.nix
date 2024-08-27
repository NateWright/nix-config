{ ... }:
let storage = "/vault/datastorage/mattermost";
in {
  containers.mattermost = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.101.10";
    localAddress = "192.168.101.11";
    forwardPorts = [{
      containerPort = 8015;
      hostPort = 8015;
    }];
    bindMounts = {
      storage = {
        hostPath = storage;
        mountPoint = storage;
        isReadOnly = false;
      };
    };
    config = { config, pkgs, lib, ... }: {

      services.mattermost = {
        enable = true;
        siteUrl = "https://mattermost.nwright.cloud";
        statePath = storage + "/state";
        listenAddress = ":8015";
        extraConfig = {
          "PluginSettings.PluginStates.com.mattermost.calls.Enable" = true;
        };
      };
      services.postgresql = {
        enable = true;
        dataDir = storage + "/postgres";
      };
      services.tailscale.enable = true;
      networking = {
        firewall = {
          enable = true;
          allowedTCPPorts = [ 8015 8443 8045 ];
          allowedUDPPorts = [ 8443 3478 ];
        };
        # Use systemd-resolved inside the container
        # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
        useHostResolvConf = lib.mkForce false;
      };

      services.resolved.enable = true;

      system.stateVersion = "23.11";
    };
  };
}
