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

  outputs = inputs@{ pkgs, home-manager, ... }: {
    nixosConfigurations = {
      nwright-surface = pkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.nwright = import ./home.nix;

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }

        ];
      };
    };
  };
}
