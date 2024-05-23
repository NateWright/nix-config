{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    localsend
    unstable.resources
    unstable.vscode
  ];
}
