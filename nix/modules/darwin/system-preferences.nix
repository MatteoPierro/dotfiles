{ ... }:
{
  system.defaults.NSGlobalDomain = {
    KeyRepeat = 2;
    InitialKeyRepeat = 15;
    "com.apple.keyboard.fnState" = true;
  };

  system.defaults.dock = {
    autohide = true;
    orientation = "bottom";
    show-recents = false;
  };

  system.defaults.controlcenter.Bluetooth = true;
}