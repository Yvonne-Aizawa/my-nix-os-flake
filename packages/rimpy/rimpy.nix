 { stdenv, lib
, fetchurl
, alsaLib
, openssl
, zlib
, pulseaudio
, autoPatchelfHook
}:

stdenv.mkDerivation rec {
  pname = "rimpy";
  version = "21.07.0";

  src = fetchurl {
    url = "https://github.com/rimpy-custom/RimPy/releases/download/1.2.6.29/RimPy_Linux.tar.gz";
    sha256 = "sha256-LIOgw0Rrg5Hpq5i/XiMy5xjQ8PsQ5rADX/pFtVMRpwU=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
  ];

  buildInputs = [
    alsaLib
    openssl
    zlib
    pulseaudio
  ];

  sourceRoot = ".";

  installPhase = ''
    mkdir $out
    # cp -r ./ $out/bin/

    install -m755 -d ./ $out/bin/

    ls -a
  '';

  meta = with lib; {
    homepage = "https://github.com/rimpy-custom/RimPy/";
    description = "Rimworld mod manager";
    platforms = platforms.linux;
  };
}