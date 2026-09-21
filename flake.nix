{
  description = "Personal and work machine configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nix-darwin = {
      url = "github:nix-darwin/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, ... }:
    let
      mkDarwin = import ./nix/lib/mk-darwin.nix inputs;
    in
    {
      darwinConfigurations = {
        personal-macbook = mkDarwin (import ./nix/hosts/personal-macbook.nix);
        work-macbook = mkDarwin (import ./nix/hosts/work-macbook.nix);
      };

      formatter.aarch64-darwin = inputs.nixpkgs.legacyPackages.aarch64-darwin.nixfmt;
      formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.nixfmt;
    };
}