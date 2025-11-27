{ lib, ... }:
{
  services.cockpit = {
    enable = true;
    port = 8021;
    settings = {
      WebService = {
        AllowUnencrypted = true;
        Origins = lib.mkForce "http://localhost:8021 https://localhost:8021";
      };
    };
  };
}
