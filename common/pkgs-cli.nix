{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    helix
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
    fd

    gh
    ripgrep
    nixfmt
    gnumake
    fastfetch
    cpufetch
    htop
    man-pages
    man-pages-posix
    zellij
    alacritty
    tailscale
  ];
}
