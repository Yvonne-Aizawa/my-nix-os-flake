{pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
        (callPackage ./yubikey.nix { })
    ];
}