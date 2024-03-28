{ lib, stdenvNoCC, fetchgit }:
stdenvNoCC.mkDerivation
rec {
  name = "ags-conf";
  src = fetchgit {
    url = "https://github.com/Aylur/dotfiles";
    sha256 = "sha256-2twcxvJSoAmtrRWGWX8SXj+zCD8fL1PvvBEkI2ZxfpM=";
    sparseCheckout = [
      "ags"
    ];
  };

  installPhase = ''
    cp -aR $src/ags $out
  '';
}
