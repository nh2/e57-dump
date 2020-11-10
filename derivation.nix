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
    # TODO: Remove when https://github.com/asmaloney/libE57Format/pull/60 is available.
    (libe57format.overrideAttrs (old: {
      # GNU patch cannot patch `CMakeLists.txt` that has CRLF endings,
      # see https://unix.stackexchange.com/questions/239364/how-to-fix-hunk-1-failed-at-1-different-line-endings-message/243748#243748
      # so convert it first.
      prePatch = ''
        ${old.prePatch or ""}
        ${dos2unix}/bin/dos2unix CMakeLists.txt
      '';
      patches = (old.patches or []) ++ [
        (fetchpatch {
          name = "libE57Format-cmake-Fix-config-filename.patch";
          url = "https://github.com/asmaloney/libE57Format/commit/279d8d6b60ee65fb276cdbeed74ac58770a286f9.patch";
          sha256 = "0fbf92hs1c7yl169i7zlbaj9yhrd1yg3pjf0wsqjlh8mr5m6rp14";
        })
      ];
      # It appears that while the patch has
      #     diff --git a/cmake/E57Format-config.cmake b/cmake/e57format-config.cmake
      #     similarity index 100%
      #     rename from cmake/E57Format-config.cmake
      #     rename to cmake/e57format-config.cmake
      # GNU patch doesn't interpret that.
      postPatch = ''
        mv cmake/E57Format-config.cmake cmake/e57format-config.cmake
      '';
      propagatedBuildInputs = [
        xercesc # Necessary for libE57Format's CMake config to work
      ];
    }))
  ];
}
