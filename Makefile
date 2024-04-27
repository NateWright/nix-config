.PHONY: desktop framework server update

all:
	echo "Please pick one"

desktop:
	nixos-rebuild switch --flake .#nwright-nixos-pc

desktop-boot:
	nixos-rebuild boot --flake .#nwright-nixos-pc

desktop-home-manager:
	home-manager switch --flake .#nwright@nwright-nixos-pc

framework:
	nixos-rebuild switch --flake .#nwright-framework

framework-boot:
	nixos-rebuild boot --flake .#nwright-framework

framework-home-manager:
	home-manager switch --flake .#nwright@framework

server:
	nixos-rebuild switch --flake .#server

server-home-manager:
	home-manager switch --flake .#nwright@server

update:
	nix flake update
