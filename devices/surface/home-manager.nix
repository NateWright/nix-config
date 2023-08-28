{ config, pkgs, home-manager, inputs, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.users.nwright = { pkgs, inputs, ... }: {
    imports = [ inputs.gBar.homeManagerModules.x86_64-linux.default ];
    programs.gBar = {
      enable = true;
    };
    home.stateVersion = "23.05";
  };
}
