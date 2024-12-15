# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ pkgs, ... }:
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    ../../../common/home-manager/helix.nix
    ../../../common/home-manager/zsh.nix
  ];

  home = {
    username = "nwright";
    homeDirectory = "/home/nwright";

    packages = with pkgs; [ gh ];
  };

  news.display = "silent";

  programs = {
    home-manager.enable = true;
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";
}
