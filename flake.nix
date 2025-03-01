# /etc/nixos/flake.nix
{
  description = "flake for nwright's machines";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.11";
    };
    nixpkgs-unstable = {
      url = "github:Nixos/nixpkgs/nixos-unstable";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.11";
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
        nwright-nixos-pc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = {
            inherit outputs inputs;
          };
          modules = [
            ./devices/nwright-nixos-pc/configuration.nix

            # home-manager-unstable.nixosModules.home-manager
            home-manager.nixosModules.home-manager
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
      # homeConfigurations = {

      # };

    };
}
