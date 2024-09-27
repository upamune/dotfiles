# nixos-wsl-configuration.nix
{ config, pkgs, ... }:

{
  imports = [
    ./common-configuration.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "nixos";
    nativeSystemd = true;
    # WSL固有の設定をここに追加
  };

  # システムパッケージ
  environment.systemPackages = with pkgs; [
    wget
    vim
    git
  ];

  # ユーザー設定
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable 'sudo' for the user.
  };

  # システムの状態バージョン。変更時は注意が必要です。
  system.stateVersion = "24.05";
}
