{ stdenv, fetchFromGitHub, hugo }:
stdenv.mkDerivation {
  name = "nwright-tech-hugo-site";

  src = fetchFromGitHub {
    owner = "NateWright";
    repo = "NateWright";
    rev = "8ba2ca59df74f72d310a7ee6100b76177c5026cb";
    sha256 = "sha256-jRtJ827dMh74CsHRYYFA1f6Vg5k4nFDEwkO4X28zRtk=";
    fetchSubmodules = true;
  };

  nativeBuildInputs = [ hugo ];
  buildPhase = ''
    cp -r $src/* .
    ${hugo}/bin/hugo
  '';

  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp -r public/* $out/
    runHook postInstall
  '';
}
