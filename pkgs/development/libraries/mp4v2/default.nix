{ stdenv, fetchurl }:

stdenv.mkDerivation rec {
  name = "mp4v2-2.0.0";

  src = fetchurl {
    url = "https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/mp4v2/${name}.tar.bz2";
    sha256 = "0f438bimimsvxjbdp4vsr8hjw2nwggmhaxgcw07g2z361fkbj683";
  };

  # From Handbrake
  # mp4v2 doesn't seem to be actively maintained any more :-/
  patches = [
    ./A02-meaningful-4gb-warning.patch
  ];
  # `faac' expects `mp4.h'.
  postInstall = "ln -s mp4v2/mp4v2.h $out/include/mp4.h";

  hardeningDisable = [ "format" ];

  meta = {
    homepage = https://code.google.com/archive/p/mp4v2/;
    maintainers = [ ];
    platforms = stdenv.lib.platforms.linux;
    license = stdenv.lib.licenses.mpl11;
  };
}
