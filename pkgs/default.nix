# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{ pkgs, inputs, system }: {

  # ags-conf = pkgs.callPackage ./ags-conf/default.nix { };
  alyur-dotfiles = pkgs.callPackage ./alyur-dotfiles.nix { };
}
