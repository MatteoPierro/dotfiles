{ pkgs, ... }:
{
  imports = [ ./librewolf.nix ];

  programs.rbw = {
    enable = true;
    settings = {
      email = "dummy@example.com";
      pinentry = pkgs.pinentry_mac;
    };
  };

  home.packages = with pkgs; [
    bitwarden-desktop
    element-desktop
    exercism
    gradle
    jdk
    jetbrains.webstorm
    maven
    nmap
    nushell
    qemu
    signal-desktop
    telegram-desktop
    texliveFull
  ];
}