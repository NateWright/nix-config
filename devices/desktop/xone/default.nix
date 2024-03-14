{ stdenv, lib, fetchFromGitHub, kernel, fetchurl, fetchpatch }:

stdenv.mkDerivation rec {
  pname = "xone";
  version = "0.3-unstable";

  src = fetchFromGitHub {
    owner = "medusalix";
    repo = pname;
    rev = "948d2302acdd6333295eaba4da06d96677290ad3";
    sha256 = "sha256-srAEw1ai5KT0rmVUL3Dut9R2mNb00AAZVCcINikh2sM=";
  };

  setSourceRoot = ''
    export sourceRoot=$(pwd)/${src.name}
  '';

  nativeBuildInputs = kernel.moduleBuildDependencies;

  makeFlags = [
    "-C"
    "${kernel.dev}/lib/modules/${kernel.modDirVersion}/build"
    "M=$(sourceRoot)"
    "VERSION=${version}"
  ];

  buildFlags = [ "modules" ];
  installFlags = [ "INSTALL_MOD_PATH=${placeholder "out"}" ];
  installTargets = [ "modules_install" ];

  meta = with lib; {
    description = "Linux kernel driver for Xbox One and Xbox Series X|S accessories";
    homepage = "https://github.com/medusalix/xone";
    license = licenses.gpl2;
    maintainers = with lib.maintainers; [ rhysmdnz ];
    platforms = platforms.linux;
  };
}
