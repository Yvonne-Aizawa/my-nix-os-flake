{ lib
, user
, home-manager
, system
, ...
};
let
pkgs = import nixpkgs {
inherit system;
config.allowUnfree = true;                              # Allow proprietary software
};
 lib = nixpkgs.lib;
in{
nixosConfigurations = {
  yvonne = lib.nixosSystem {
    inherit system;
    modules = [
      ./configuration.nix
      home-manager.nixosModules.home-manager
      {
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.yvonne = {
          imports = [ ./home.nix ];
        };
      }
    ];
  };
};
}



