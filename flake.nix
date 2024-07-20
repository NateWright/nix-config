# /etc/nixos/flake.nix
{
  description = "flake for nwright's machines";

  inputs = {
    nixpkgs = { url = "github:NixOS/nixpkgs/nixos-24.05"; };
    nixpkgs-unstable = { url = "github:Nixos/nixpkgs/nixos-unstable"; };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
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
  };

  outputs = { self, nixpkgs, nixpkgs-unstable, nixos-hardware, nixos-cosmic
    , home-manager, home-manager-unstable, vscode-server, ... }@inputs:
    let inherit (self) outputs;
    in rec {
      overlays = import ./overlays { inherit inputs; };
      nixosConfigurations = {
        nwright-framework = nixpkgs-unstable.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit outputs inputs; };
          modules = [
            nixos-cosmic.nixosModules.default
            nixos-hardware.nixosModules.framework-13-7040-amd
            ./devices/nwright-framework/configuration.nix
          ];
        };
        nwright-nixos-pc = nixpkgs-unstable.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit outputs inputs; };
          modules = [
            nixos-cosmic.nixosModules.default
            ./devices/nwright-nixos-pc/configuration.nix
          ];
        };
        server-nixos-1 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit outputs inputs; };
          modules = [
            vscode-server.nixosModules.default
            ./devices/server-nixos-1/configuration.nix
          ];
        };
        linode-nixos-1 = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit outputs inputs; };
          modules = [ ./devices/linode-nixos-1/configuration.nix ];
        };
      };
      homeConfigurations = {
        "nwright@nwright-nixos-pc" =
          home-manager-unstable.lib.homeManagerConfiguration {
            pkgs =
              nixpkgs-unstable.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
            # extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
            # > Our main home-manager configuration file <
            modules = [ ./devices/desktop/home-manager/home.nix ];
          };

        "nwright@framework" =
          home-manager-unstable.lib.homeManagerConfiguration {
            pkgs =
              nixpkgs-unstable.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
            extraSpecialArgs = {
              inherit outputs inputs;
            }; # Pass flake inputs to our config
            # > Our main home-manager configuration file <
            modules = [ ./devices/framework/home-manager/home.nix ];
          };

        "nwright@server-nixos-1" = home-manager.lib.homeManagerConfiguration {
          pkgs =
            nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = {
            inherit outputs inputs;
          }; # Pass flake inputs to our config
          # > Our main home-manager configuration file <
          modules = [ ./devices/server-nixos-1/home-manager/home.nix ];
        };

      };

    };
}

