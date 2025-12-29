{ pkgs, ... }:
{
  services.sanoid = {
    enable = true;
    templates = {
      "template_production" = {
        yearly = 0;
        monthly = 3;
        daily = 30;
        hourly = 36;
        autosnap = true;
        autoprune = true;
      };
      "template_none" = {
        yearly = 0;
        monthly = 0;
        daily = 0;
        hourly = 0;
        autosnap = false;
        autoprune = true;
      };
    };
    datasets = {
      "rpool/root" = {
        useTemplate = [
          "template_none"
        ];
      };
      "rpool/nix" = {
        useTemplate = [
          "template_none"
        ];
      };
      "rpool/home" = {
        useTemplate = [
          "template_production"
        ];
      };
      "rpool/var" = {
        useTemplate = [
          "template_production"
        ];
      };
      "vault" = {
        useTemplate = [
          "template_production"
        ];
        recursive = true;
        processChildrenOnly = true;
      };
    };
  };
  environment.systemPackages = with pkgs; [
    sanoid
  ];
}
