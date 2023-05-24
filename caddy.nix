{ config, pkgs, ... }:
{
  services.caddy = {
    enable = true;
    user = "root";
    group = "root";
    extraConfig = ''
      nixos.raptor-roach.ts.net {
        redir /.well-known/carddav /cloud/remote.php/dav 301
	      redir /.well-known/caldav /cloud/remote.php/dav 301
        redir /.well-known/webfinger /cloud/index.php/.well-known/webfinger 301
        redir /.well-known/nodeinfo /cloud/index.php/.well-known/nodeinfo 301
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
      https://nixos.raptor-roach.ts.net:447 {
        encode gzip
        reverse_proxy localhost:8010
      }
    '';
  };
}
