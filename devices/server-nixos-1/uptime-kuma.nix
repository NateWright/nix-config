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
  systemd.services = {

    uptime-sanoid-monitor-health = sanoidService {
      type = "--monitor-health";
      url = "https://uptime.nwright.cloud/api/push/1l1sZLumGCHrZ6n0Xv74m5d0xB3V4Vd2";
    };

    uptime-sanoid-monitor-snapshots = sanoidService {
      type = "--monitor-snapshots";
      url = "https://uptime.nwright.cloud/api/push/mhz1MdLwcp2Q2bXIrFz1TBZoDHJVa3YM";
    };

    uptime-sanoid-monitor-capacity = sanoidService {
      type = "--monitor-capacity";
      url = "https://uptime.nwright.cloud/api/push/dqPzWcEZPTESqY3cgHeg1VR45059HQBc";
    };

  };
}
