{ ... }: {
  services.caddy = {
    enable = true;
    virtualHosts = {
      "nwright.tech" = {
        extraConfig = ''
          reverse_proxy /_matrix/* 100.93.196.119:8008
          reverse_proxy /_synapse/client/* 100.93.196.119:8008

          reverse_proxy 100.93.196.119:8013
        '';
      };
      "nwright.tech:8448" = {
        extraConfig = ''
          reverse_proxy /_matrix/* 100.93.196.119:8008
        '';
      };
      "sliding-sync.nwright.tech" = {
        extraConfig = ''
          reverse_proxy 100.93.196.119:8015
        '';
      };
    };
  };
}
