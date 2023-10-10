{ config, pkgs, ... }:
{
    virtualisation.oci-containers = {
        backend = "podman";
        containers = {
            # podman run -t -d --cap-add=MKNOD -p 127.0.0.1:9980:9980 -e "domain=nwright.cloud" -e "username=admin" -e "password=secret" -e "extra_params=--o:ssl.enable=false --o:ssl.termination=true" collabora/code
            # collabora = {
            #     image = "collabora/code:latest";
            #     autoStart = true;
            #     ports = [ "9980:9980" ];
            #     environment = {
            #         password = "secret";
            #         username = "admin";
            #         domain = "nwright.cloud";
            #         extra_params = "--o:ssl.enable=false --o:ssl.termination=true";
            #     };
            #     extraOptions = [ "-t" "--cap-add=MKNOD" ];
            # };
            # collabora = {
            #     image = "collabora/code:latest";
            #     autoStart = true;
            #     ports = [ "9980:9980" ];
            #     environment = {
            #         "UID" = "$(id -u $(logname))";
            #         "GID" = "$(id -g $(logname))";
            #         password = "secret";
            #         username = "admin";
            #         domain = "nwright.cloud";
            #         extra_params = "--o:ssl.enable=false --o:ssl.termination=true";
            #     };
            #     extraOptions = [ "--pull=newer" "-t" "--cap-add=ALL" ];
            # };
        };

    };
    # systemd.services.collabora = {
    #     path = [ pkgs.podman-compose ];
    #     script = ''
    #     ${pkgs.podman-compose}/bin/podman-compose up -d -f /vault/containers/collabraCODE/docker-compose.yml
    #     '';
    #     wantedBy = ["multi-user.target"];
    #     # If you use podman
    #     after = ["podman.service" "podman.socket"];
    #     # If you use docker
    #     # after = ["docker.service" "docker.socket"];
    # };
}