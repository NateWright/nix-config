{ stdenvNoCC, fetchzip }:
stdenvNoCC.mkDerivation {
  pname = "synapse-admin";
  version = "0.10.1";
  dontBuild = true;
  src = fetchzip {
    url =
      "https://github.com/Awesome-Technologies/synapse-admin/releases/download/0.10.1/synapse-admin-0.10.1.tar.gz";
    hash = "sha256-GJn35/Z03vPUgWw+eoeBiLk0HZqZMolwizhexQxo0Gk=";
  };
  installPhase = ''
    runHook preInstall
    mkdir -p $out
    cp -r $src/* $out/
    runHook postInstall
  '';
}
