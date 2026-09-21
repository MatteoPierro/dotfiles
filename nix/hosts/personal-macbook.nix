{
  hostName = "personal-macbook";
  username = "matteopierro";

  homeModules = [ ../modules/profiles/personal.nix ];
  modules = [ ../modules/darwin/apps/personal.nix ];
}