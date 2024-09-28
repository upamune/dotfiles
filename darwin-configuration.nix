# darwin-configuration.nix
{ config, pkgs, ... }:

{
  imports = [
    ./common-configuration.nix
  ];

  # Nixデーモンの自動アップグレードを有効化
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # システムにインストールするパッケージ
  environment.systemPackages = with pkgs; [
    # macOS特有のパッケージをここに追加
  ];

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

  # システムの言語と地域の設定
  system.defaults.NSGlobalDomain.AppleLanguages = [
    "en-JP"
    "ja-JP"
  ];
  system.defaults.NSGlobalDomain.AppleLocale = "en_JP";

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
