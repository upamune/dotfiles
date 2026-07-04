# home-manager でインストールするパッケージの一覧
{ lib, pkgs, ... }:

let
  inherit (pkgs.stdenv) isDarwin isLinux;
in
{
  home.packages =
    with pkgs;
    [
      # Git
      ghq
      lazygit
      tig
      # jujutsu
      jujutsu
      # Nix
      cachix
      devbox
      # Python
      uv
      # Container
      colima
      docker-client
      docker-compose
      lazydocker
      # LLM
      ollama
      qdrant
      # CLI
      _1password-cli
      asciinema
      google-cloud-sdk
      htop
      jq
      tldr
      # Fonts
      fontconfig
      nerd-fonts.fira-code
    ]
    ++ lib.optionals isDarwin [
      # macOS固有のパッケージ
      tailscale
    ]
    ++ lib.optionals isLinux [
      # Linux (WSL) 固有のパッケージ
    ];
}
