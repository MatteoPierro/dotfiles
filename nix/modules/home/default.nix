{ pkgs, ... }:
{
  imports = [ ./packages.nix ];

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";

  targets.darwin = {
    linkApps.enable = false;
    copyApps.enable = pkgs.stdenv.hostPlatform.isDarwin;
  };

  # Launch via LaunchServices so the apps keep their Accessibility permissions.
  launchd.agents = {
    rectangle = {
      enable = true;
      config = {
        ProgramArguments = [ "/usr/bin/open" "-a" "Rectangle" ];
        RunAtLoad = true;
      };
    };
    jumpcut = {
      enable = true;
      config = {
        ProgramArguments = [ "/usr/bin/open" "-a" "Jumpcut" ];
        RunAtLoad = true;
      };
    };
  };
}