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

    terminator
    alacritty

    google-chrome

    unstable.vscode
    nixpkgs-fmt
  ];
}
