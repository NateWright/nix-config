{ ... }:
{
  hardware.alsa.enablePersistence = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #   # jack.enable = true;

    wireplumber.extraConfig."11-bluetooth-policy" = {
      "wireplumber.settings" = {
        "bluetooth.autoswitch-to-headset-profile" = false;
      };
    };
    #   # Low latency audio config
    #   extraConfig = {
    #     pipewire."92-low-latency" = {
    #       context.properties = {
    #         default.clock.rate = 48000;
    #         default.clock.quantum = 32;
    #         default.clock.min-quantum = 32;
    #         default.clock.max-quantum = 32;
    #       };
    #     };
    #     pipewire-pulse."92-low-latency" = {
    #       context.modules = [
    #         {
    #           name = "libpipewire-module-protocol-pulse";
    #           args = {
    #             pulse.min.req = "32/48000";
    #             pulse.default.req = "32/48000";
    #             pulse.max.req = "32/48000";
    #             pulse.min.quantum = "32/48000";
    #             pulse.max.quantum = "32/48000";
    #           };
    #         }
    #       ];
    #       stream.properties = {
    #         node.latency = "32/48000";
    #         resample.quality = 1;
    #       };
    #     };
    #   };

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
}
