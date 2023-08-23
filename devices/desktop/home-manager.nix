{ config, pkgs, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.users.nwright = { pkgs, ... }: {
    home.stateVersion = "23.05";
    programs.terminator.enable = true;
    programs.terminator.config = {
      global_config.suppress_multiple_term_dialog = true;
      # default
      profiles = {
        default = {
          background_color = "#1f1305";
          foreground_color = "#b4e1fd";
          palette = "#3f3f3f:#ff0883:#83ff08:#ff8308:#0883ff:#8308ff:#08ff83:#bebebe:#474747:#ff1e8e:#8eff1e:#ff8e1e:#0883ff:#8e1eff:#1eff8e:#c4c4c4";

        };
        noetic = {
          palette = "#000000:#ff5555:#55ff55:#ffff55:#5555ff:#ff55ff:#55ffff:#bbbbbb:#555555:#ff5555:#55ff55:#ffff55:#5555ff:#ff55ff:#55ffff:#ffffff";
          use_custom_command = true;
          custom_command = "distrobox enter noetic";

        };
      };
      layouts.default = {
        window0 = {
          type = "Window";
          parent = "";
        };
        child1 = {
          type = "Terminal";
          parent = "window0";
        };
      };
    };
  };
}
