{ pkgs, ... }:
{
  home.packages = with pkgs; [
    _1password-cli
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