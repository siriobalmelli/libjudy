{
  system ? builtins.currentSystem,
  nixpkgs ? import <nixpkgs> { inherit system; }
}:

with nixpkgs;

stdenv.mkDerivation rec {
  name = "libjudy";

  src = ./.;

  # gcc 4.8 optimisations break judy.
  # http://sourceforge.net/p/judy/mailman/message/31995144/
  preConfigure = stdenv.lib.optionalString stdenv.cc.isGNU ''
    configureFlagsArray+=("CFLAGS=-fno-strict-aliasing -fno-aggressive-loop-optimizations")
  '';

  meta = {
    homepage = http://judy.sourceforge.net/;
    license = stdenv.lib.licenses.lgpl21Plus;
    description = "State-of-the-art C library that implements a sparse dynamic array";
    platforms = stdenv.lib.platforms.unix;
  };
}
