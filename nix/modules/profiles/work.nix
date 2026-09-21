{ pkgs, ... }:
{
  home.packages = with pkgs; [
    _1password-cli
    _1password-gui
    act
    amazon-ecr-credential-helper
    bruno
    cloudflared
    insomnia
    libpq
    mariadb.client
    poetry
    progress
    protobuf
  ];
}