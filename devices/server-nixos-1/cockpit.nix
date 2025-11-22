{ ... }:
{
  services.cockpit = {
    enable = true;
    port = 8021;
    settings = {
      WebService = {
        AllowUnencrypted = true;
      };
    };
  };
}
