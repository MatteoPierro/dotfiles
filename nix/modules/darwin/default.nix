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

  # Expose zsh plugins installed by Home Manager under /etc/profiles/per-user.
  environment.pathsToLink = [
    "/share/zsh-autosuggestions"
    "/share/zsh-syntax-highlighting"
  ];

  nix-homebrew = {
    enable = true;
    user = username;
    autoMigrate = true;
  };
}