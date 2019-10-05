{
  system ? builtins.currentSystem,
  nixpkgs ? import <nixpkgs> { inherit system; }
}:

with nixpkgs;

stdenv.mkDerivation rec {
  name = "libjudy";
  meta = {
    homepage = https://github.com/siriobalmelli/libjudy;
    license = stdenv.lib.licenses.lgpl21Plus;
    description = "State-of-the-art C library that implements a sparse dynamic array";
    platforms = stdenv.lib.platforms.unix;
    maintainers = [ "https://github.com/siriobalmelli" ];
  };

  src = nix-gitignore.gitignoreSource [] ./.;

  doCheck = true;

  # gcc 4.8 optimisations break judy.
  # http://sourceforge.net/p/judy/mailman/message/31995144/
  preConfigure = stdenv.lib.optionalString stdenv.cc.isGNU ''
    configureFlagsArray+=("CFLAGS=-fno-strict-aliasing -fno-aggressive-loop-optimizations")
  '';
}
