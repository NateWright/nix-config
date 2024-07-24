# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {

  # ags-conf = pkgs.callPackage ./ags-conf/default.nix { };
  alyur-dotfiles = pkgs.callPackage ./alyur-dotfiles.nix { };
  synapse-admin = pkgs.callPackage ./synapse-admin/default.nix { };
  lube-logger = pkgs.callPackage ./lubelogger/default.nix { };
}
