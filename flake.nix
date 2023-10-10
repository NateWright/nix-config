# /etc/nixos/flake.nix
{
  description = "flake for nwright-surface";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-23.05";
    };
    nixpkgs-unstable = {
      url = "github:Nixos/nixpkgs/nixos-unstable";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gBar.url = "github:scorpion-26/gBar";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
    in
    rec {
      overlays = import ./overlays { inherit inputs; };
      nixosConfigurations = {
        nwright-surface = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit outputs inputs; };
          modules = [
            ./devices/surface/configuration.nix
          ];
        };
        nwright-nixos-pc = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./devices/desktop/configuration.nix
          ];
        };
      };
      homeConfigurations = {
        "nwright@nwright-surface" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
          # > Our main home-manager configuration file <
          modules = [ ./devices/surface/home-manager/home.nix ];
        };
        "nwright@nwright-nixos-pc" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux; # Home-manager requires 'pkgs' instance
          # extraSpecialArgs = { inherit inputs; }; # Pass flake inputs to our config
          # > Our main home-manager configuration file <
          modules = [ ./devices/desktop/home-manager/home.nix ];
        };

      };

    };
}