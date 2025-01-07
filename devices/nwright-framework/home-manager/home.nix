# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{
  inputs,
  ...
}:
{
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    ../../../common/home-manager/vscode.nix
    ../../../common/home-manager/helix.nix
    ../../../common/home-manager/zsh.nix
    ../../../common/home-manager/zed-editor.nix
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  home = {
    username = "nwright";
    homeDirectory = "/home/nwright";
  };

  catppuccin = {
    enable = true;
    flavor = "macchiato";
    accent = "mauve";
  };
  programs = {
    home-manager.enable = true;
    alacritty.enable = true;
    bat.enable = true;
    bottom.enable = true;
    fuzzel.enable = true;
    lazygit.enable = true;
    zellij.enable = true;
  };

  services.mpris-proxy.enable = true; # Enable bluetooth pause/play

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";
}
