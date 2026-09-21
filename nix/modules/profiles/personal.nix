{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bitwarden-desktop
    element-desktop
    exercism
    gradle
    jdk
    jetbrains.webstorm
    librewolf
    maven
    nmap
    nushell
    qemu
    rbw
    ruby-build
    signal-desktop
    telegram-desktop
    texliveFull
  ];
}