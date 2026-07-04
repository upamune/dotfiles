# home-manager の入口。設定は関心ごとに分割して imports で読み込む。
{
  lib,
  pkgs,
  username,
  ...
}:

let
  inherit (pkgs.stdenv) isDarwin;
in
{
  imports = [
    ./packages.nix
    ./cli.nix
    ./git.nix
    ./starship.nix
    ./zsh.nix
  ];

  home.username = username;
  home.homeDirectory =
    if isDarwin then lib.mkForce "/Users/${username}" else lib.mkForce "/home/${username}";
  home.stateVersion = "25.05";

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  fonts.fontconfig.enable = true;

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
