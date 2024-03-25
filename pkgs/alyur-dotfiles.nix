{ lib, stdenvNoCC, fetchgit }:
stdenvNoCC.mkDerivation
rec {
  name = "asztal";
  src = fetchgit {
    url = "https://github.com/Aylur/dotfiles";
  };

  installPhase = ''
    cp -aR $src $out
  '';
}
