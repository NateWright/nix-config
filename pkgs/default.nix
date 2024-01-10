# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
{pkgs, inputs}: {
  nwright-hugo-website = pkgs.callPackage inputs.nwright-tech-website.packages.x86_64-linux.nwright-hugo-website { };
}