# /etc/nixos/flake.nix
{
  description = "flake for nwright's machines";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-25.11";
    };
    nixpkgs-unstable = {
      url = "github:Nixos/nixpkgs/nixos-unstable";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager-unstable = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    catppuccin.url = "github:catppuccin/nix";
    stylix.url = "github:nix-community/stylix/release-25.11";
    stylix-unstable = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    authentik-nix.url = "github:nix-community/authentik-nix";
  };

  outputs =
    {
      self,
      nixpkgs,
      nixpkgs-unstable,
      nixos-hardware,
      home-manager,
      home-manager-unstable,
      catppuccin,
      stylix,
      stylix-unstable,
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
            home-manager-unstable.nixosModules.home-manager
            nixos-hardware.nixosModules.framework-13-7040-amd
            # catppuccin.nixosModules.catppuccin
            stylix-unstable.nixosModules.stylix
            ./devices/nwright-framework/configuration.nix
          ];
        };
        # nwright-nixos-pc = nixpkgs-unstable.lib.nixosSystem {
        #   system = "x86_64-linux";
        #   specialArgs = {
        #     inherit outputs inputs;
        #   };
        #   modules = [
        #     ./devices/nwright-nixos-pc/configuration.nix

        #     home-manager-unstable.nixosModules.home-manager
        #     # home-manager.nixosModules.home-manager
        #     nixos-cosmic.nixosModules.default
        #     catppuccin.nixosModules.catppuccin

        #     chaotic.nixosModules.nyx-cache
        #     chaotic.nixosModules.nyx-overlay
        #     chaotic.nixosModules.nyx-registry
        #   ];
        # };
        server-nixos-1 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit outputs inputs;
          };
          modules = [
            home-manager.nixosModules.home-manager
            ./devices/server-nixos-1/configuration.nix
          ];
        };

        server-nixos-2 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit outputs inputs;
          };
          modules = [
            home-manager.nixosModules.home-manager
            catppuccin.nixosModules.catppuccin
            stylix.nixosModules.stylix
            ./devices/server-nixos-2/configuration.nix
          ];
        };

        linode-nixos-1 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit outputs inputs;
          };
          modules = [
            home-manager.nixosModules.home-manager
            ./devices/linode-nixos-1/configuration.nix
          ];
        };
      };
      homeConfigurations = {
      };

    };
}
