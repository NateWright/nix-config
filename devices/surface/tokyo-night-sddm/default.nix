{ stdenv, fetchFromGitHub }:
{
  sddm-sugar-dark = stdenv.mkDerivation rec {
    pname = "tokyo-night-sddm";
    version = "1..0";
    dontBuild = true;
    src = fetchFromGitHub {
      owner = "rototrash";
      repo = "tokyo-night-sddm";
      sha256 = "";
    };

    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/tokyo-night-sddm
    '';

  };
}
