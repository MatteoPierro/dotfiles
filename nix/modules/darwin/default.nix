{
  pkgs,
  username,
  ...
}:
{
  imports = [
    ./apps/common.nix
    ./system-preferences.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  users.users.${username}.home = "/Users/${username}";
  system.primaryUser = username;
  system.stateVersion = 6;

  fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

  nix-homebrew = {
    enable = true;
    user = username;
    autoMigrate = true;
  };
}