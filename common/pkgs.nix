{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    alacritty
    localsend
    resources
    vscode

    # Zed pkgs
    # unstable.zed-editor
    nixd
  ];
}
