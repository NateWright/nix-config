{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    swtpm
  ];
  programs.dconf.enable = true;
  programs.virt-manager.enable = true;

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        swtpm.enable = true;
      };
    };
    spiceUSBRedirection.enable = true;
  };
}
