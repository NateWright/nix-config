{ lib, stdenvNoCC, fetchFromGitHub }:

stdenvNoCC.mkDerivation rec {
  pname = "icomoon-feather";
  version = "1.0";
  src = fetchFromGitHub {
    owner = "adi1090x";
    repo = "polybar-themes";
    rev = "4851133fdc2cd0c683ca1eaab10d67738875b679";
    sha256 = "sha256-Bv9ae7P67zDxwTo9As4Znel+Mgfr6m8G/Pj109aydJw=";
  };
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/fonts/truetype
    cp $src/fonts/panels/icomoon_feather.ttf $out/share/fonts/truetype 
    runHook postInstall 
  '';

  meta = with lib; {
    description = "icomoon font";
    longDescription = "icomoon font";
    homepage = "https://github.com/adi1090x/polybar-themes/tree/master";
    license = licenses.gpl3Only;
    platforms = platforms.all;
    maintainers = with maintainers; [ nwright ];
  };
}
