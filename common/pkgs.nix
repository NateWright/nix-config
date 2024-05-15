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

    adw-gtk3

    terminator
    alacritty
    zellij

    google-chrome
    localsend
    resources

    unstable.vscode
  ];
}
