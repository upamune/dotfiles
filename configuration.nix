# ref: https://qiita.com/suin/items/809236c1a6235ca012d7
{ pkgs, ... }:
{
  # システムにインストールするパッケージ
  environment.systemPackages = with pkgs; [
    vim
    git
    zsh
  ];

  # Nixデーモンの自動アップグレードを有効化
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;

  # zshの設定
  programs.zsh.enable = true;
  environment.shells = [
    pkgs.zsh
  ];

  # 非自由パッケージを許可
  nixpkgs.config.allowUnfree = true;

  # Finder設定
  system.defaults.finder = {
    # 全てのファイル拡張子を表示
    AppleShowAllExtensions = true;

    # 隠しファイルを表示
    AppleShowAllFiles = true;

    # デスクトップアイコンの非表示
    CreateDesktop = false;

    # 拡張子変更時の警告を無効化
    FXEnableExtensionChangeWarning = false;

    # パスバーを表示
    ShowPathbar = true;

    # ステータスバーを表示
    ShowStatusBar = true;
  };

  # Dock設定
  system.defaults.dock = {
    # Dockの自動非表示
    autohide = true;

    # 最近使用したアプリケーションの非表示
    show-recents = false;

    # Dockアイコンの拡大機能
    magnification = false;

    # Dockの位置
    orientation = "left";

    # ウィンドウ最小化エフェクト
    mineffect = "scale";

    # アプリケーション起動時のアニメーションを有効化
    launchanim = true;
  };

  # 下位互換性のため（変更時はchangelogを確認）
  system.stateVersion = 4;

  # ターゲットプラットフォーム
  nixpkgs.hostPlatform = "aarch64-darwin";
}
