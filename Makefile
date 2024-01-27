.PHONY: server update

server:
	sudo nixos-rebuild switch --flake .#server

update:
	nix flake update