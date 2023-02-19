{ config, pkgs, ... }:
{
  services.nginx = {
    enable = true;
    recommendedGzipSettings = true;
    recommendedOptimisation = true;
    recommendedProxySettings = true;
    recommendedTlsSettings = true;
    virtualHosts = {
      "nextcloud" = {
        serverName = "nixos.raptor-roach.ts.net";
        # enableACME = true;
        # acmeRoot = null;
        sslCertificateKey = "/etc/nixos/nixos.raptor-roach.ts.net.key";
        sslCertificate = "/etc/ssl/certs/ca-certificates.crt";
        # addSSL = true;
        forceSSL = true;
        locations."/" = {proxyPass = "http://127.0.0.1:8009"; proxyWebsockets = true;};
      };
    };
  };
}
