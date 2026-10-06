{
  nix-darwin,
  home-manager,
  nur,
  nix-homebrew,
  mac-app-util,
  ...
}:
{
  hostName,
  username,
  system ? "aarch64-darwin",
  homeModules ? [ ],
  modules ? [ ],
}:
nix-darwin.lib.darwinSystem {
  inherit system;
  specialArgs = { inherit username; };

  modules = [
    ../modules/darwin
    home-manager.darwinModules.home-manager
    nix-homebrew.darwinModules.nix-homebrew
    {
      networking.hostName = hostName;
      nixpkgs.hostPlatform = system;
      nixpkgs.config.allowUnfree = true;
      nixpkgs.overlays = [ nur.overlays.default ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        users.${username}.imports = [
          ../modules/home
          mac-app-util.homeManagerModules.default
        ] ++ homeModules;
      };
    }
  ] ++ modules;
}