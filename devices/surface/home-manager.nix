{ config, pkgs, home-manager, ... }: {

  home-manager.users.nwright = { pkgs, ... }: {
    home.stateVersion = "23.05";
  };

}
