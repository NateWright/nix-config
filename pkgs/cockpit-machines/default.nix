{
  lib,
  stdenv,
  fetchzip,
  gettext,
  pkgs,
}:

stdenv.mkDerivation rec {
  pname = "cockpit-machines";
  version = "344";
  src = fetchzip {
    url = "https://github.com/cockpit-project/cockpit-machines/releases/download/${version}/cockpit-machines-${version}.tar.xz";
    sha256 = "";
  };

  nativeBuildInputs = [
    gettext
  ];

  makeFlags = [
    "DESTDIR=$(out)"
    "PREFIX="
  ];

  postPatch = ''
    #substituteInPlace Makefile --replace dist $out/dist
    touch pkg/lib/cockpit.js
    touch pkg/lib/cockpit-po-plugin.js
    touch dist/manifest.json
  '';

  postFixup = ''
    substituteInPlace $out/share/cockpit/machines/manifest.json \
      --replace-warn "/usr/share/dbus-1/system.d/org.libvirt.conf" "${pkgs.libvirt-dbus}/share/dbus-1/system.d/org.libvirt.conf"
    gunzip $out/share/cockpit/machines/index.js.gz
    sed -i "s#/usr/bin/python3#/usr/bin/env python3#ig" $out/share/cockpit/machines/index.js
    sed -i "s#/usr/bin/pwscore#/usr/bin/env pwscore#ig" $out/share/cockpit/machines/index.js
    gzip -9 $out/share/cockpit/machines/index.js
  '';

  dontBuild = true;

  meta = {
    description = "Cockpit UI for virtual machines";
    license = lib.licenses.lgpl21;
    homepage = "https://github.com/cockpit-project/cockpit-machines";
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ gaelj ];
  };
}
