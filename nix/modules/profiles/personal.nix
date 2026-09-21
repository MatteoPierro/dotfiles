{ pkgs, ... }:
{
  home.packages = with pkgs; [
    element-desktop
    exercism
    gradle
    jdk
    jetbrains.webstorm
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