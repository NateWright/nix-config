{ lib, fetchGit }:
stdenvNoCC.mkDerivation
rec {
  pname = "ags-conf";
  src = fetchGit {
    url = "https://github.com/Aylur/dotfiles";
    sparseCheckout = [
      "ags"
    ];
  };

  installPhase = ''
    cp -aR $src/ags $out
  '';
}
