# nixos-wsl-configuration.nix
{
  config,
  pkgs,
  user,
  ...
}:

{
  imports = [
    ./common-configuration.nix
  ];

  # システムパッケージ
  environment.systemPackages = with pkgs; [
    vim
    git
  ];

  # ユーザー設定
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
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
