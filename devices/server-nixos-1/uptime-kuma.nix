{ pkgs, ... }:
let
  sanoidService = { type, url }: {
    description = "Runs sanoid ${type} and pushes to uptime kuma";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
    path = with pkgs; [
      sanoid
      coreutils
      curl
    ];

    # The Bash script content goes directly inside the '' string block
    script = ''
      PUSH_URL="${url}"

      OUTPUT=$(sanoid ${type})

      if [[ $OUTPUT == OK* ]]; then
        # If all checks are OK, ping healthchecks
        curl -s -o /dev/null \
        --data-urlencode "status=up" \
        --data-urlencode "msg=''${OUTPUT}" \
        --data-urlencode "ping=" \
        $PUSH_URL
        echo "All checks are OK. Healthcheck pinged successfully."
      else
        curl -s -o /dev/null \
        --data-urlencode "status=down" \
        --data-urlencode "msg=''${OUTPUT}" \
        --data-urlencode "ping=" \
        $PUSH_URL
        echo "One or more checks did not return OK. Failure ping sent."
      fi

    '';

    serviceConfig = {
      Type = "oneshot";
      User = "root";
    };
    startAt = "*:0/6";

  };
in
{
  # services.monit = {
  #   enable = true;
  #   config = ''
  #     # Global configuration options
  #     set daemon 60           # Check services every 60 seconds
  #     set logfile syslog

  #     # Set up the web interface
  #     set httpd port 2812 and
  #         use address 127.0.0.1
  #         allow localhost
  #   '';
  # };
  systemd.services = {
    uptime-sanoid-monitor-health = sanoidService {
      type = "--monitor-health";
      url = "https://uptime.nwright.cloud/api/push/1l1sZLumGCHrZ6n0Xv74m5d0xB3V4Vd2";
    };
    # uptime-sanoid-monitor-health = {
    #   description = "Runs sanoid --monitor-health and pushes to uptime kuma";

    #   path = with pkgs; [
    #     sanoid
    #     coreutils
    #     curl
    #   ];

    #   # The Bash script content goes directly inside the '' string block
    #   script = ''
    #     PUSH_URL="https://uptime.nwright.cloud/api/push/1l1sZLumGCHrZ6n0Xv74m5d0xB3V4Vd2"

    #     OUTPUT=$(sanoid --monitor-health)

    #     if [[ $OUTPUT == OK* ]]; then
    #       # If all checks are OK, ping healthchecks
    #       curl -s -o /dev/null \
    #       --data-urlencode "status=up" \
    #       --data-urlencode "msg=''${OUTPUT}" \
    #       --data-urlencode "ping=" \
    #       $PUSH_URL
    #       echo "All checks are OK. Healthcheck pinged successfully."
    #     else
    #       curl -s -o /dev/null \
    #       --data-urlencode "status=down" \
    #       --data-urlencode "msg=''${OUTPUT}" \
    #       --data-urlencode "ping=" \
    #       $PUSH_URL
    #       echo "One or more checks did not return OK. Failure ping sent."
    #     fi

    #   '';

    #   serviceConfig = {
    #     Type = "oneshot";
    #     User = "root";
    #   };
    #   startAt = "*:0/6";
    # };

    uptime-sanoid-monitor-snapshots = {
      description = "Runs sanoid --monitor-snapshots and pushes to uptime kuma";

      path = with pkgs; [
        sanoid
        coreutils
        curl
      ];

      # The Bash script content goes directly inside the '' string block
      script = ''
        PUSH_URL="https://uptime.nwright.cloud/api/push/mhz1MdLwcp2Q2bXIrFz1TBZoDHJVa3YM?status=up&msg=OK&ping="

        OUTPUT=$(sanoid --monitor-snapshots)

        if [[ $OUTPUT == OK* ]]; then
          # If all checks are OK, ping healthchecks
          curl -s -o /dev/null $PUSH_URL
          echo "All checks are OK. Healthcheck pinged successfully."
        else
          echo "One or more checks did not return OK. Failure ping sent."
        fi

      '';

      serviceConfig = {
        Type = "oneshot";
        User = "root";
      };
      startAt = "*:0/6";
    };

    uptime-sanoid-monitor-capacity = {
      description = "Runs sanoid --monitor-capacity and pushes to uptime kuma";

      path = with pkgs; [
        sanoid
        coreutils
        curl
      ];

      # The Bash script content goes directly inside the '' string block
      script = ''
        PUSH_URL="https://uptime.nwright.cloud/api/push/dqPzWcEZPTESqY3cgHeg1VR45059HQBc?status=up&msg=OK&ping="

        OUTPUT=$(sanoid --monitor-capacity)

        if [[ $OUTPUT == OK* ]]; then
          # If all checks are OK, ping healthchecks
          curl -s -o /dev/null $PUSH_URL
          echo "All checks are OK. Healthcheck pinged successfully."
        else
          echo "One or more checks did not return OK. Failure ping sent."
        fi

      '';

      serviceConfig = {
        Type = "oneshot";
        User = "root";
      };
      startAt = "*:0/6";
    };
  };
}
