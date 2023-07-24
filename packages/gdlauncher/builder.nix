{pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
        (callPackage ./gdlauncher.nix { })
    ];
}