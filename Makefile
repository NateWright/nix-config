.PHONY: desktop framework server update

all:
	echo "Please pick one"

desktop:
	nixos-rebuild switch --flake .#nwright-nixos-pc

framework:
	nixos-rebuild switch --flake .#nwright-framework

server:
	nixos-rebuild switch --flake .#server

update:
	nix flake update