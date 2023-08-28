# /etc/nixos/flake.nix
{
  description = "flake for nwright-surface";

  inputs = {
    pkgs = {
      url = "github:NixOS/nixpkgs/nixos-23.05";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "pkgs";
    };
    gBar.url = "github:scorpion-26/gBar";
  };

  outputs = { self, pkgs, home-manager, gBar, ... }: {
    nixosConfigurations = {
      nwright-surface = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = attrs;
        modules = [
          ./configuration.nix
          ./home-manager.nix
        ];
      };
    };
  };
}
