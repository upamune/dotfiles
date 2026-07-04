# macOS (nix-darwin) のシステム設定
{ user, ... }:

{
  imports = [
    ../modules/common.nix
  ];

  # Determinate Nix を使うので nix-darwin の Nix 管理は無効化する
  nix.enable = false;

  # nix-darwin のシステム設定を適用するプライマリユーザー
  system.primaryUser = user;

  # Finder設定
  system.defaults.finder = {
    AppleShowAllExtensions = true;
    AppleShowAllFiles = true;
    CreateDesktop = false;
    FXEnableExtensionChangeWarning = false;
    ShowPathbar = true;
    ShowStatusBar = true;
  };

  # Dock設定
  system.defaults.dock = {
    autohide = true;
    show-recents = false;
    magnification = false;
    orientation = "left";
    mineffect = "scale";
    launchanim = true;
  };

  # キーボードの設定
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  # ターゲットプラットフォーム
  nixpkgs.hostPlatform = "aarch64-darwin";

  # システムの状態バージョン
  system.stateVersion = 4;
}
