{pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
        (callPackage ./rimpy.nix { })
    ];
}