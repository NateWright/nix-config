{ ... }:
{
  services.avahi = {
    enable = true;
    allowInterfaces = [
      "enp4s0"
      "enp7s0"
    ];
    ipv6 = false;
    reflector = true;
  };
}
