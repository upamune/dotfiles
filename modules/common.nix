# すべてのマシンで共有するシステム設定
{ pkgs, ... }:
{
  # システムにインストールするパッケージ
  environment.systemPackages = with pkgs; [
    vim
    git
    zsh
    nixfmt
    ripgrep
    gnumake
  ];

  # zshの設定
  programs.zsh.enable = true;
  environment.shells = [ pkgs.zsh ];

  # 非自由パッケージを許可
  nixpkgs.config.allowUnfree = true;
}
