# WSL2 (NixOS) のシステム設定
{ pkgs, ... }:

{
  imports = [
    ../modules/common.nix
  ];

  wsl = {
    enable = true;
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
    startMenuLaunchers = true;
  };

  # システムパッケージ
  environment.systemPackages = with pkgs; [
    wget
    dbus
  ];

  # ユーザー設定
  users.users.nixos = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };

  environment.sessionVariables = {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";
  };

  system.stateVersion = "25.05";
}
