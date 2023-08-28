{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation rec {
  pname = "source-code-pro";
  version = "1.0";
  src = fetchFromGitHub {
    owner = "adobe-fonts";
    repo = "source-code-pro";
    rev = "d3f1a5962cde503f9409c21e58527611d4a19ef1";
    sha256 = "sha256-Bv9ae7P67zDxwTo9As4Znel+Mgfr6m8G/Pj109aydJw=";
  };
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/fonts/truetype
    mkdir -p $out/share/fonts/opentype
    cp $src/OTF/*.otf $out/share/fonts/opentype
    cp $src/TTF/*.ttf $out/share/fonts/truetype 
    runHook postInstall 
  '';

  meta = with lib; {
    description = "adobe source code pro font";
    longDescription = "adobe source code pro font";
    homepage = "https://github.com/adobe-fonts/source-code-pro";
    license = licenses.ofl;
    platforms = platforms.all;
    maintainers = with maintainers; [ nwright ];
  };
}
