{
  browser,
  passwordManager,
}:
{ username, ... }:
let
  homeManagerApps = "/Users/${username}/Applications/Home Manager Trampolines";
  passwordManagerPath =
    if passwordManager ? homeManagerApp then
      "${homeManagerApps}/${passwordManager.homeManagerApp}.app"
    else
      passwordManager.app;
in
{
  system.defaults.dock.persistent-apps = [
    "${homeManagerApps}/${browser}.app"
    "${homeManagerApps}/WezTerm.app"
    "${homeManagerApps}/Visual Studio Code.app"
    "/System/Applications/Music.app"
    passwordManagerPath
    "/System/Applications/System Settings.app"
  ];
}