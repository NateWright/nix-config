{ stdenv
, lib
, fetchgit
, makeWrapper
, pkg-config
, glew
, libX11
, libXcomposite
, glfw
, libpulseaudio
, ffmpeg
, wayland
, libdrm
, libva
, libcap
, libglvnd
, libXrandr
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "gpu-screen-recorder";
  version = "2023.11.18";

  src = fetchgit {
    url = "https://repo.dec05eba.com/gpu-screen-recorder";
    rev = "5a8900e3c199c5e25a0819992f002614867c924e";
    hash = "sha256-it+Ur/pUCGo8OyA8ih2CZy16KqrUcfQRjCQO1auWR8c=";
  };

  nativeBuildInputs = [
    pkg-config
    makeWrapper
  ];

  buildInputs = [
    glew
    libX11
    libXcomposite
    glfw
    libpulseaudio
    ffmpeg
    wayland
    libdrm
    libcap
    libva
    libglvnd
    libXrandr
  ];

  buildPhase = ''
    ./build.sh
  '';

  postInstall = ''
    install -Dt $out/bin gpu-screen-recorder gsr-kms-server
    mkdir $out/bin/.wrapped
    mv $out/bin/gpu-screen-recorder $out/bin/.wrapped/
    makeWrapper "$out/bin/.wrapped/gpu-screen-recorder" "$out/bin/gpu-screen-recorder" \
    --prefix LD_LIBRARY_PATH : ${libglvnd}/lib \
    --prefix PATH : $out/bin
  '';


  meta = with lib; {
    description = "A screen recorder that has minimal impact on system performance by recording a window using the GPU only";
    homepage = "https://git.dec05eba.com/gpu-screen-recorder/about/";
    license = licenses.gpl3Only;
    maintainers = with maintainers; [ babbaj keenanweaver nwright ];
    platforms = [ "x86_64-linux" ];
  };
})
