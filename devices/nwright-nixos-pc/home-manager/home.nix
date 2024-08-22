# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)

{ lib, config, pkgs, ... }: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
    ../../../common/home-manager/gtk-plasma.nix
    ../../../common/home-manager/vscode.nix
    ../../../common/home-manager/helix.nix
    ../../../common/home-manager/zsh.nix
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
  catppuccin = {
    flavor = "macchiato";
    accent = "mauve";
    enable = true;
  };

  programs.home-manager.enable = true;
  programs.git.enable = true;
  programs.alacritty.enable = true;
  programs.bat.enable = true;
  programs.bottom.enable = true;
  programs.fuzzel.enable = true;
  programs.lazygit.enable = true;
  programs.zellij.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.05";
}
