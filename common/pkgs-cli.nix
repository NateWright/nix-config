{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    vim
    wget
    unzip
    zip
    glow
    bat
    git
    ripgrep
    gnumake
    dua
    fastfetch
    cpufetch
    htop
    bottom
    man-pages
    man-pages-posix
    zellij
    terminator
    alacritty
  ];
}

