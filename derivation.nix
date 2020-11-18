{
  stdenv,
  lib,
  fetchpatch,
  dos2unix,
  xercesc,
  meson,
  ninja,
  pkgconfig,
  cmake,
  libe57format,
}:

stdenv.mkDerivation rec {
  pname = "e57-dump";
  version = "1.0";

  src = lib.cleanSource ./.;

  nativeBuildInputs = [
    meson
    ninja
    pkgconfig
    cmake # to find libe57format
  ];

  buildInputs = [
    libe57format
  ];
}
