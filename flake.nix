# /etc/nixos/flake.nix
{
  description = "flake for nwright-surface";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-23.11";
    };
    nixpkgs-unstable = {
      url = "github:Nixos/nixpkgs/nixos-unstable";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # gBar.url = "github:scorpion-26/gBar";
    # hyprland.url = "github:hyprwm/Hyprland";
    # hyprland-contrib = {
    #   url = "github:hyprwm/contrib";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    vscode-server.url = "github:nix-community/nixos-vscode-server";
    nwright-hugo-website.url = "github:NateWright/NateWright";


  };

  outputs =
    { self
    , nixpkgs
    , nixpkgs-unstable
    , nixos-hardware
    , nixos-cosmic
    , home-manager
    , vscode-server
    , nwright-hugo-website
    , ...
    }@inputs:
    let
      inherit (self) outputs;
    in
    rec {
      overlays = import ./overlays { inherit inputs; };
      nixosConfigurations = {
        nwright-framework = nixpkgs-unstable.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit outputs inputs; };
          modules = [
            {
              nix.settings = {
                substituters = [ "https://cosmic.cachix.org/" ];
                trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
              };
            }
            nixos-cosmic.nixosModules.default
            nixos-hardware.nixosModules.framework-13-7040-amd
            ./devices/framework/configuration.nix
          ];
        };
        nwright-nixos-pc = nixpkgs-unstable.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit outputs inputs; };
          modules = [
            # {
            #   nix.settings = {
            #     substituters = [ "https://cosmic.cachix.org/" ];
            #     trusted-public-keys = [ "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE=" ];
            #   };
            # }
            # nixos-cosmic.nixosModules.default
            ./devices/desktop/configuration.nix
          ];
        };
        server = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          specialArgs = { inherit outputs inputs; };
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

