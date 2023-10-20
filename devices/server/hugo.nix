{ stdenv, fetchFromGitHub, hugo }:
stdenv.mkDerivation {
  name = "nwright-tech-hugo-site";

  src = fetchFromGitHub {
    owner = "NateWright";
    repo = "NateWright";
    rev = "554d6eaa3b22a3d99a491928660074180c4d824e";
    sha256 = "sha256-AQyzLk7oPXgPo2vM5C/U//AgtVYHVuAsx4nI6W3SiLQ=";
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
