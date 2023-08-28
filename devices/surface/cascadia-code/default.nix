{ lib, stdenvNoCC, fetchzip }:

stdenvNoCC.mkDerivation rec {
  pname = "CaskadiaCode-test";
  version = "2.3.1";

  src = fetchzip {
    url = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.3.1/CascadiaCode.zip";
    stripRoot = false;
    hash = "sha256-e0DPSiQf6Ucoe3Sp+CaEPktngrrJ0bOBPRulhsM4MU0=";
  };

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/opentype
    cp *.otf $out/share/fonts/opentype

    runHook postInstall
  '';

  meta = with lib; {
    homepage = "https://github.com/ryanoasis/nerd-fonts";
    description = "Locked package 2.3.1";
    license = licenses.ofl;
    platforms = platforms.all;
    maintainers = with maintainers; [ nwright ];
  };
}
