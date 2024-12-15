# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{
  pkgs,
  inputs,
  outputs,
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
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  # nixpkgs = {
  #   # You can add overlays here
  #   overlays = [
  #     # If you want to use overlays exported from other flakes:
  #     # neovim-nightly-overlay.overlays.default

  #     # Or define it inline, for example:
  #     # (final: prev: {
  #     #   hi = final.hello.overrideAttrs (oldAttrs: {
  #     #     patches = [ ./change-hello-to-hi.patch ];
  #     #   });
  #     # })
  #     outputs.overlays.additions
  #   ];
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
  };

  news.display = "silent";

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

  # Enable bluetooth pause/play
  services.mpris-proxy.enable = true;

  # Gnome fractional scaling
  # dconf.settings = {
  #   "org/gnome/mutter" = {
  #     experimental-features = [ "scale-monitor-framebuffer" ];
  #   };
  # };

  # Nicely reload system units when changing configs
  # systemd.user.startServices = "sd-switch";

  home.stateVersion = "23.11";
}
