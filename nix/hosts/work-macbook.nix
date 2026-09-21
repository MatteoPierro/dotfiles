{
  hostName = "work-macbook";
  username = "matteopierro";

  homeModules = [ ../modules/profiles/work.nix ];
  modules = [
    ../modules/darwin/apps/work.nix
    (import ../lib/mk-dock.nix {
      browser = "Google Chrome";
      passwordManager.homeManagerApp = "1Password";
    })
  ];
}