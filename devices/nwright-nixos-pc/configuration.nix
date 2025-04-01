# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  config,
  pkgs,
  inputs,
  outputs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ./amd.nix
    # ./audio.nix

    ../../common/nix-settings.nix
    ../../common/pkgs.nix
    ../../common/pkgs-cli.nix

    ../../common/de/common.nix
    ../../common/de/plasma.nix
  ];

  nixpkgs = {
    overlays = [
      # Add overlays your own flake exports (from overlays and pkgs dir):
      outputs.overlays.stable-packages
      outputs.overlays.unstable-packages
      outputs.overlays.modifications
      outputs.overlays.additions
    ];
    config = {
      allowUnfree = true;
    };
  };

  # Bootloader.
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_cachyos;
    supportedFilesystems = [ "ntfs" ];
    #   blacklistedKernelModules = [
    #     "xpad"
    #     "mt76x2u"
    #   ];
  };

  fileSystems = {
    "/".options = [ "compress=zstd" ];
    "/home".options = [ "compress=zstd" ];
    "/nix".options = [
      "compress=zstd"
      "noatime"
    ];
    "/home/nwright/Vault".options = [ "compress=zstd" ];
  };

  networking = {
    hostName = "nwright-nixos-pc";
    networkmanager.enable = true;
    # wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];

      # allow the Tailscale UDP port through the firewall
      allowedUDPPorts = [ config.services.tailscale.port ];
      # allow you to SSH in over the public internet
      # allowedTCPPorts = [ ];
    };
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nwright = {
    isNormalUser = true;
    description = "Nathan Wright";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "kvm"
      "libvirtd"
    ];
    packages = with pkgs; [ firefox ];
    shell = pkgs.zsh;
  };
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.nwright = import ./home-manager/home.nix;
    extraSpecialArgs = {
      inherit outputs inputs;
    }; # Pass flake inputs to our config
    backupFileExtension = "hm-backup";
  };
  catppuccin = {
    enable = true;
    flavor = "macchiato";
    accent = "mauve";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # cosmic-term
    usbutils
    tailscale
    nextcloud-client
    distrobox
    cifs-utils # Needed for automounting
    htop
    lm_sensors
    radeontop
    godot_4
    gpu-screen-recorder
    pavucontrol
    steamtinkerlaunch

    unstable.r2modman
    inputs.umu.packages.x86_64-linux.umu-launcher

    (pkgs.wrapOBS {
      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
      ];
    })
  ];
  programs = {
    steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      gamescopeSession.enable = true;
    };
    gamescope.enable = true;
    gamemode.enable = true;
    nh = {
      enable = true;
      flake = "/home/nwright/nix-config";
    };
    zsh.enable = true;
    virt-manager.enable = true;
  };

  # List services that you want to enable:
  services = {
    gvfs.enable = true;
    fwupd.enable = true;
    openssh.enable = true;
    tailscale.enable = true;
    flatpak.enable = true;
  };

  virtualisation = {
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
    podman.enable = false;
    docker.enable = true;
  };

  hardware = {
    xone.enable = true;
    xpadneo.enable = true;
    firmware = [ pkgs.xow_dongle-firmware ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
