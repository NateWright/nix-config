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
    ./fonts.nix
    ../../common/nixpkgs.nix
    ../../common/nix-settings.nix
    ../../common/pkgs.nix
    ../../common/pkgs-cli.nix

    ../../common/de/common.nix
    ../../common/de/gnome.nix
  ];

  # Bootloader.
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };

      efi.canTouchEfiVariables = true;
      timeout = 0;
    };
    # kernelPackages = inputs.chaotic.legacyPackages.x86_64-linux.linuxPackages_cachyos;
  };

  fileSystems = {
    "/".options = [
      "compress=zstd"
      "noatime"
    ];
    "/home".options = [
      "compress=zstd"
      "noatime"
    ];
    "/nix".options = [
      "compress=zstd"
      "noatime"
    ];
    "/swap".options = [ "noatime" ];
  };

  swapDevices = [ { device = "/swap/swapfile"; } ];

  networking = {
    hostName = "nwright-framework";
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;

    firewall = {
      # enable the firewall
      enable = true;

      # always allow traffic from your Tailscale network
      trustedInterfaces = [ "tailscale0" ];

      # allow the Tailscale UDP port through the firewall
      allowedUDPPorts = [
        config.services.tailscale.port
        7236
        5353
      ];

      # allow you to SSH in over the public internet
      allowedTCPPorts = [
        22
        7236
        7250
      ];
    };
  };
  # networking.interfaces.br0.useDHCP = true;
  # networking.bridges = {
  #   "br0" = {
  #     interfaces = [ "wlp1s0" ];
  #   };
  # };

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
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
  };

  services = {
    # Printing
    printing.enable = true;
    # printing.drivers = [ pkgs.hplip ];
    avahi.enable = true;
    avahi.nssmdns4 = true;
    avahi.openFirewall = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
    };

    fwupd = {
      enable = true;
      extraRemotes = [ "lvfs-testing" ];
    };

    flatpak.enable = true;
    tailscale.enable = true;
    kmscon = {
      enable = true;
      useXkbConfig = true;
    };
  };
  virtualisation = {
    docker.enable = true;
    docker.storageDriver = "btrfs";
    libvirtd.enable = true;
  };

  security.rtkit.enable = true; # Pipewire enhancement

  hardware = {
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Experimental = true;
          ControllerMode = "dual";
          MultiProfile = "multiple";
          AutoEnable = true;
        };
      };
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nwright = {
    isNormalUser = true;
    description = "nwright";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
      "libvirtd"
      "kvm"
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
    cifs-utils
    tpm2-tss

    nextcloud-client
    libreoffice-fresh
    hunspell
    hunspellDicts.en_US

    qemu
    bridge-utils

    distrobox
    (unstable.pkgs.wrapOBS {
      plugins = with unstable.pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-vaapi
      ];
    })
  ];

  programs = {
    nh = {
      enable = true;
      flake = "/home/nwright/nix-config";
    };
    zsh.enable = true;
    virt-manager.enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?
}
