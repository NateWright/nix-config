# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ lib, config, pkgs, ... }:
let
  common = "../../../common";
in
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ${common}/home-manager/gtk.nix
    ${common}/home-manager/vscode.nix
    ${common}/home-manager/helix.nix
    ${common}/home-manager/nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = (_: true);
    };
  };

  home = {
    username = "nwright";
    homeDirectory = "/home/nwright";
  };



  # Add stuff for your user as you see fit:
  # programs.neovim.enable = true;
  # home.packages = with pkgs; [ steam ];

  # Enable home-manager and git
  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.terminator = {
    enable = true;
    config = {
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

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
