.PHONY: desktop framework server update

all:
	echo "Please pick one"

desktop:
	sudo nixos-rebuild switch --flake .#nwright-nixos-pc

framework:
	sudo nixos-rebuild switch --flake .#nwright-framework

server:
	sudo nixos-rebuild switch --flake .#server

update:
	nix flake update