# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ pkgs, inputs, ... }:
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    ../../../common/home-manager/git.nix
    ../../../common/home-manager/helix.nix
    ../../../common/home-manager/zsh.nix
    inputs.catppuccin.homeModules.catppuccin
  ];

  # nixpkgs = {
  #   # You can add overlays here
  #   overlays = [ outputs.overlays.additions ];
  #   # Configure your nixpkgs instance
  #   config = {
  #     # Disable if you don't want unfree packages
  #     allowUnfree = true;
  #     # Workaround for https://github.com/nix-community/home-manager/issues/2942
  #     allowUnfreePredicate = (_: true);
  #   };
  # };

  home = {
    username = "nwright";
    homeDirectory = "/home/nwright";

    packages = with pkgs; [ gh ];
  };

  news.display = "silent";

  catppuccin = {
    enable = true;
    flavor = "macchiato";
    accent = "mauve";
  };
  programs = {
    home-manager.enable = true;
    bat.enable = true;
    bottom.enable = true;
    lazygit.enable = true;
    zellij.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";
}
