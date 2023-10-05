# /etc/nixos/flake.nix
{
  description = "flake for nwright-surface";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-23.05";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    gBar.url = "github:scorpion-26/gBar";
    hyprland-contrib = {
      url = "github:hyprwm/contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    vscode-server.url = "github:nix-community/nixos-vscode-server";

  };

  outputs = { nixpkgs, home-manager, vscode-server, ... }@inputs:
    {
      nixosConfigurations = {
        nwright-surface = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit inputs; };
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
        server = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            vscode-server.nixosModules.default
            ./devices/server/configuration.nix
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
