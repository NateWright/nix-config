{ stdenv, fetchFromGitHub, hugo }:
stdenv.mkDerivation {
  name = "nwright-tech-hugo-site";

  src = fetchFromGitHub {
    owner = "NateWright";
    repo = "NateWright";
  };

  nativeBuildInputs = [ hugo ];
  phases = [ "unpackPhase" "buildPhase" ];
  buildPhase = ''
    hugo -s . -d "$out"
  '';
}
