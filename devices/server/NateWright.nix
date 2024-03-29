{ config, pkgs, ... }:
let
  serverName = "nwright.tech";
  webRoot = "/var/www/${serverName}";
in
{
  systemd.services.${serverName} = {
    enable = true;
    description = ''
      https://${serverName} source
    '';
    serviceConfig = {
      Type = "oneshot";
    };
    path = [ pkgs.nix ];
    startAt = "*:0/5";
    script = ''
      set -ex

      nix build github:NateWright/NateWright --out-link ${webRoot} --extra-experimental-features nix-command --extra-experimental-features flakes --refresh
    '';
  };
}
