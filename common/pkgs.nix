{ config, lib, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    unzip
    zip
    bat
    git
    gnumake
    dua
    neofetch
    cpufetch
    htop
    bottom
    man-pages
    man-pages-posix

    adw-gtk3

    terminator
    alacritty
    zellij

    google-chrome
    localsend

    unstable.vscode
    nixpkgs-fmt
  ];
}
