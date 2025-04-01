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

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ../../../common/home-manager/gtk-plasma.nix
    # ../../../common/home-manager/vscode.nix
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
    flavor = "macchiato";
    accent = "mauve";
    enable = true;
  };

  programs = {
    home-manager.enable = true;
    git.enable = true;
    alacritty.enable = true;
    bat.enable = true;
    bottom.enable = true;
    fuzzel.enable = true;
    lazygit.enable = true;
    zellij.enable = true;
  };

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
