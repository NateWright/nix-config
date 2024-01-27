.PHONY: desktop server update

desktop:
	sudo nixos-rebuild switch --flake .#nwright-nixos-pc

server:
	sudo nixos-rebuild switch --flake .#server

update:
	nix flake update