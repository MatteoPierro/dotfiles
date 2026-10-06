{
  hostName = "personal-macbook";
  username = "matteopierro";

  homeModules = [ ../modules/profiles/personal.nix ];
  modules = [
    ../modules/darwin/apps/personal.nix
    (import ../lib/mk-dock.nix {
      browser = "LibreWolf";
      passwordManager.homeManagerApp = "Bitwarden";
    })
  ];
}