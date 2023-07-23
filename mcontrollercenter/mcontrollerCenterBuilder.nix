{pkgs, ...}:
{
    environment.systemPackages = with pkgs; [
        (callPackage ./mcontrolcenter.nix { })
    ];
}