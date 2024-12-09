{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    alacritty
    localsend
    unstable.resources
    unstable.vscode
  ];
}
