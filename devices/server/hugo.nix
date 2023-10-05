{ stdenv, fetchFromGitHub, hugo }:
stdenv.mkDerivation {
  name = "nwright-tech-hugo-site";

  src = fetchFromGitHub {
    owner = "NateWright";
    repo = "NateWright";
    rev = "8ba2ca59df74f72d310a7ee6100b76177c5026cb";
  };

  nativeBuildInputs = [ hugo ];
  phases = [ "unpackPhase" "buildPhase" ];
  buildPhase = ''
    hugo -s . -d "$out"
  '';
}
