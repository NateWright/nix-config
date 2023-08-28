{ config, lib, pkgs, home-manager, ... }: {
  # do something with home-manager here, for instance:
  imports = [ home-manager.nixosModules.default ];
  home-manager.users.nwright = { pkgs, ... }: {
    home.stateVersion = "23.05";
  };

}
