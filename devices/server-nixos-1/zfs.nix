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
    };
    datasets = {
      "rpool" = {
        useTemplate = [
          "template_production"
        ];
        recursive = true;
        processChildrenOnly = true;
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
