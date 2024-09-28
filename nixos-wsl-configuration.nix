# nixos-wsl-configuration.nix
{ config, pkgs, ... }:

{
  imports = [
    ./common-configuration.nix
  ];

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
    defaultUser = "nixos";
    startMenuLaunchers = true;
    nativeSystemd = true;
  };

  # システムパッケージ
  environment.systemPackages = with pkgs; [
    wget
    vim
    git
    dbus
  ];

  # ユーザー設定
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };

  # システムの状態バージョン。変更時は注意が必要です。
  system.stateVersion = "24.05";
}
