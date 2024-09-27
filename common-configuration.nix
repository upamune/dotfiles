# common-configuration.nix
{ pkgs, ... }:
{
  # システムにインストールするパッケージ
  environment.systemPackages = with pkgs; [
    vim
    git
    zsh
    nixfmt-rfc-style
    lunarvim
    ripgrep
  ];

  # zshの設定
  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];

  # 非自由パッケージを許可
  nixpkgs.config.allowUnfree = true;
}
