{ nixpkgs ? import (builtins.fetchGit {
    url = "https://siriobalmelli@github.com/siriobalmelli-foss/nixpkgs.git";
    ref = "refs/tags/sirio-2021-07-12";
    }) {}
}:

with nixpkgs;

stdenv.mkDerivation rec {
  name = "libjudy";
  meta = with lib; {
    homepage = https://github.com/siriobalmelli/libjudy;
    license = licenses.lgpl21Plus;
    description = "State-of-the-art C library that implements a sparse dynamic array";
    platforms = lib.platforms.unix;
    maintainers = with maintainers; [ siriobalmelli ];
  };

  src = nix-gitignore.gitignoreSource [] ./.;

  doCheck = true;

  # gcc 4.8 optimisations break judy.
  # http://sourceforge.net/p/judy/mailman/message/31995144/
  preConfigure = lib.optionalString stdenv.cc.isGNU ''
    configureFlagsArray+=("CFLAGS=-fno-strict-aliasing -fno-aggressive-loop-optimizations")
  '';
}
