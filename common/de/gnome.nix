{ pkgs, ... }: {
  services.xserver = {
    displayManager = {
      gdm = {
        enable = true;
        wayland = true;
      };
    };
    desktopManager = { gnome.enable = true; };
  };

  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnome-extension-manager
    nautilus-python
    sushi
    gnomeExtensions.pop-shell
    nautilus-open-any-terminal
    adw-gtk3
  ];
  services.xserver.desktopManager.gnome.extraGSettingsOverridePackages =
    with pkgs;
    [ nautilus-open-any-terminal ];

}
