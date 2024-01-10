# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{pkgs, inputs, system}: {
  nwright-hugo-website = inputs.nwright-hugo-website.packages.${system}.nwright-hugo-website;
}