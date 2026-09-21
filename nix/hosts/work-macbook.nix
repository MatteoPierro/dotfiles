{
  hostName = "work-macbook";
  username = "matteopierro";

  homeModules = [ ../modules/profiles/work.nix ];
  modules = [ ../modules/darwin/apps/work.nix ];
}