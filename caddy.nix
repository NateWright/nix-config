{ config, pkgs, ... }:
{
  services.caddy = {
    enable = true;
    user = "root";
    group = "root";
    extraConfig = ''
      nixos.raptor-roach.ts.net {
        redir /.well-known/carddav /cloud/remote.php/carddav 301
	      redir /.well-known/caldav /cloud/remote.php/caldav 301
        handle_path /cloud*  {
          encode gzip
          reverse_proxy localhost:8009
        }
      }
      https://nixos.raptor-roach.ts.net:444 {
        encode gzip
        reverse_proxy 127.0.0.1:9980
      }
      https://nixos.raptor-roach.ts.net:446 {
        encode gzip
        reverse_proxy 127.0.0.1:2343
      }
    '';
  };
}
