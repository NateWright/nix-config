{ pkgs }:
let
  serverName = "nwright.tech";
  webRoot = "/var/www/${serverName}";
in
{
  systemd.services.nate-wright = {
    enable = true;
    path = [ pkgs.nix ];
    serviceConfig = {
      Type = "oneshot";
      startAt = "*:0/5";
      script = ''
        set -ex

        result=$(nix build github:NateWright/NateWright)

        ln -sfT $result${webRoot} ${webRoot}
      '';
    };
  };
}
