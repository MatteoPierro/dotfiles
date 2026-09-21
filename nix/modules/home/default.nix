{ pkgs, ... }:
{
  imports = [ ./packages.nix ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";

  targets.darwin = {
    linkApps.enable = false;
    copyApps.enable = pkgs.stdenv.hostPlatform.isDarwin;
  };
}