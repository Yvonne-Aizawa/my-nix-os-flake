{pkgs}:{
          gdlauncher = pkgs.appimageTools.wrapType1 {
              name = "gdlauncher";
              version = "15";

              src = pkgs.fetchurl {
                  url = "https://github.com/gorilla-devs/GDLauncher/releases/download/v1.1.30/GDLauncher-linux-setup.AppImage";
                  hash = "sha256-UOQlqbh8rmzFn6ZWZEc5QxjmVzLdVbY/vFuLOLrFt6U=";
              };
          };
          gdlauncher-desktop = pkgs.writeTextDir "share/applications/gdlauncher.desktop" ''
              [Desktop Entry]
              Version=15
              Type=Application
              Name=gdlauncher
              Exec=gdlauncher
              Icon=~/Applications/icons/gdlauncher.png
          '';
      }