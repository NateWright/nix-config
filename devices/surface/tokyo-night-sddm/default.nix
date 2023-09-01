{ lib, stdenvNoCC, fetchFromGitHub }:
{
  stdenvNoCC.mkDerivation rec {
  pname = "tokyo-night-sddm";
  version = "1..0";
  dontBuild = true;
  src = fetchFromGitHub {
    owner = "rototrash";
    repo = "tokyo-night-sddm";
    rev = "320c8e74ade1e94f640708eee0b9a75a395697c6";
    sha256 = "";
  };

  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -aR $src $out/share/sddm/themes/tokyo-night-sddm
  '';

};
}
