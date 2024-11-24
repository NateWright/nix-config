{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    vim
    wget
    unzip
    zip

    # rust alternatives
    glow
    bat
    dua
    git
    bottom

    ripgrep
    nixfmt-rfc-style
    gnumake
    fastfetch
    cpufetch
    htop
    man-pages
    man-pages-posix
    zellij
    alacritty
  ];
}
