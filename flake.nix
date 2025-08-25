# /etc/nixos/flake.nix
{
  description = "flake for nwright's machines";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.05";
    };
    nixpkgs-unstable = {
      url = "github:Nixos/nixpkgs/nixos-unstable";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vscode-server.url = "github:nix-community/nixos-vscode-server";
    catppuccin.url = "github:catppuccin/nix";
    umu.url = "github:Open-Wine-Components/umu-launcher?dir=packaging/nix";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    authentik-nix.url = "github:nix-community/authentik-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      nixos-hardware,
      nixos-cosmic,
      home-manager,
      home-manager-unstable,
      vscode-server,
      catppuccin,
      chaotic,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      systems = [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      overlays = import ./overlays { inherit inputs; };
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

      nixosConfigurations = {
        nwright-framework = nixpkgs-unstable.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit outputs inputs;
          };
          modules = [
            ./devices/nwright-framework/configuration.nix

            home-manager-unstable.nixosModules.home-manager
            nixos-cosmic.nixosModules.default
            nixos-hardware.nixosModules.framework-13-7040-amd
            catppuccin.nixosModules.catppuccin
          ];
        };
        nwright-nixos-pc = nixpkgs-unstable.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit outputs inputs;
          };
          modules = [
            ./devices/nwright-nixos-pc/configuration.nix

            home-manager-unstable.nixosModules.home-manager
            # home-manager.nixosModules.home-manager
            nixos-cosmic.nixosModules.default
            catppuccin.nixosModules.catppuccin

            chaotic.nixosModules.nyx-cache
            chaotic.nixosModules.nyx-overlay
            chaotic.nixosModules.nyx-registry
          ];
        };
        server-nixos-1 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit outputs inputs;
          };
          modules = [
            vscode-server.nixosModules.default
            home-manager.nixosModules.home-manager
            ./devices/server-nixos-1/configuration.nix
          ];
        };
        linode-nixos-1 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit outputs inputs;
          };
          modules = [ ./devices/linode-nixos-1/configuration.nix ];
        };
      };
      homeConfigurations = {
        "nwright@nwright-framework" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = {
            inherit outputs inputs;
          }; # Pass flake inputs to our config
          # > Our main home-manager configuration file <
          modules = [
            {
              # You can import other home-manager modules here
              imports = [
                # If you want to use home-manager modules from other flakes (such as nix-colors):
                # inputs.nix-colors.homeManagerModule
                # ../../../common/home-manager/vscode.nix
                common/home-manager/helix.nix
                common/home-manager/zsh.nix
                common/home-manager/zed-editor.nix
                inputs.catppuccin.homeModules.catppuccin
              ];

              home = {
                username = "nwright";
                homeDirectory = "/home/nwright/distrobox/home/dev";
              };

              catppuccin = {
                enable = true;
                flavor = "macchiato";
                accent = "mauve";
              };
              programs = {
                home-manager.enable = true;
                alacritty.enable = true;
                bat.enable = true;
                bottom.enable = true;
                fuzzel.enable = true;
                lazygit.enable = true;
                zellij.enable = true;
              };

              services.mpris-proxy.enable = true; # Enable bluetooth pause/play

              # Nicely reload system units when changing configs
              # systemd.user.startServices = "sd-switch";

              home.stateVersion = "23.11";
            }
          ];
        };
      };

    };
}
