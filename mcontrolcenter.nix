{
  pkgs ? import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/4fe8d07066f6ea82cda2b0c9ae7aee59b2d241b3.tar.gz";
    sha256 = "sha256:06jzngg5jm1f81sc4xfskvvgjy5bblz51xpl788mnps1wrkykfhp";
  }) {}
}:
pkgs.stdenv.mkDerivation rec {
  pname = "mcontrolcenter";
  version = "0.4.0";

  src = pkgs.fetchgit {
    url = "https://github.com/yvonne-aizawa/MControlCenter/";
    rev = "41db7cf590187176a7b251f4310f0a9dd671d8f7";
    sha256 = "sha256-QG+N5LplAJflVoEa9FnMn7S6UpZQuqGrFgijX/d7e08=";
  };

  buildInputs = [
    pkgs.simgrid
    pkgs.boost
    pkgs.cmake
    pkgs.cmakeMinimal
    pkgs.libqt5pas
    pkgs.qt5.full
    pkgs.xkbset
  ];

  configurePhase = ''
    cmake .
  '';

  buildPhase = ''
    make
  '';

  installPhase = ''
    cd ./scripts/
    sh ./create_installer.sh

    ls MControlCenter-0.4.0 -a
    ls MControlCenter-0.4.0/app -a
    cd ./MControlCenter-0.4.0/
    # move the bin
    install -vDm755 ./app/mcontrolcenter $out/usr/mcontrolcenter
    # move destkop file
    install -vDm644 ./app/mcontrolcenter.desktop $out/usr/share/applications/mcontrolcenter.desktop
    # move svg file
    install -vDm644 ./app/mcontrolcenter.svg $out/usr/share/icons/hicolor/scalable/apps/mcontrolcenter.svg
    # move helper
    install -vDm755 ./app/mcontrolcenter-helper $out/usr/libexec/mcontrolcenter-helper
    # move dbus conf
    install -vDm644 ./app/mcontrolcenter-helper.conf $out/usr/share/dbus-1/system.d/mcontrolcenter-helper.conf
    # move service file
    install -vDm644 ./app/mcontrolcenter.helper.service $out/usr/share/dbus-1/system-services/mcontrolcenter.helper.service
  '';

}