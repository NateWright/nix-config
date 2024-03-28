{ lib, stdenvNoCC, fetchgit }:
stdenvNoCC.mkDerivation
rec {
  name = "asztal";
  src = fetchgit {
    url = "https://github.com/Aylur/dotfiles";
    sha256 = "sha256-9nnz5rAu8SOr1d/0oD0EdmxeL1RIfdzD+inkvB/vVCg=";
  };

  installPhase = ''
    cp -aR $src $out
  '';
}
