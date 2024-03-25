{ lib, stdenvNoCC, fetchgit }:
stdenvNoCC.mkDerivation
rec {
  name = "ags-conf";
  src = fetchgit {
    url = "https://github.com/Aylur/dotfiles";
    sparseCheckout = [
      "ags"
    ];
  };

  installPhase = ''
    cp -aR $src/ags $out
  '';
}
