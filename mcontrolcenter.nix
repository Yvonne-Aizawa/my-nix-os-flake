# { pkgs ? import
#     (fetchTarball {
#       url = "https://github.com/NixOS/nixpkgs/archive/4fe8d07066f6ea82cda2b0c9ae7aee59b2d241b3.tar.gz";
#       sha256 = "sha256:06jzngg5jm1f81sc4xfskvvgjy5bblz51xpl788mnps1wrkykfhp";
#     })
#     { }
# }:
{ pkgs ? import <nixpkgs> { } }:
pkgs.stdenv.mkDerivation rec {
  pname = "mcontrolcenter";
  version = "0.4.0";

  src = pkgs.fetchgit {
    url = "https://github.com/yvonne-aizawa/MControlCenter/";
    rev = "5cd0ad29a7af90796060e9b821c2b6cfbf9d87eb";
    sha256 = "sha256-V3SwV5Q+O+yOaMOeTRfFzB8QSHpqeTY6ngsFQZvBRSc=";
  };
  nativeBuildInputs = [
    pkgs.cmake
  ];
  buildInputs = [
    pkgs.simgrid
    pkgs.boost
    pkgs.cmake
    pkgs.libqt5pas
    pkgs.qt5.full
    pkgs.xkbset
  ];


  buildPhase = ''
    make
  '';

  installPhase = ''
    pwd
    cd ..
    ls -a
    cd ./scripts/
    pwd
    echo "running create installer"
    sh ./create_installer.sh
    ls -a
    cd ./MControlCenter-0.4.0/
    echo "moving binary to bin"
    ls ./app -a
    # move the bin
    install -vDm755 ./app/mcontrolcenter $out/bin/mcontrolcenter
    # move destkop file
    install -vDm644 ./app/mcontrolcenter.desktop $out/share/applications/mcontrolcenter.desktop
    # move svg file
    install -vDm644 ./app/mcontrolcenter.svg $out/share/icons/hicolor/scalable/apps/mcontrolcenter.svg
    # move helper
    install -vDm755 ./app/mcontrolcenter-helper $out/bin/mcontrolcenter-helper
    # move dbus conf
    install -vDm644 ./app/mcontrolcenter-helper.conf $out/usr/share/dbus-1/system.d/mcontrolcenter-helper.conf
    # move service file
    install -vDm644 ./app/mcontrolcenter.helper.service $out/etc/systemd/system/mcontrolcenter.helper.service
  '';


}
