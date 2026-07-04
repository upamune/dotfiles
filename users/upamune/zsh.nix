# zsh の設定。宣言的に書けるもの (履歴・補完・キーマップ) はここで設定し、
# それ以外のスクリプトは ./zshrc に置く。
{ config, pkgs, ... }:

let
  inherit (pkgs.stdenv) isLinux;
in
{
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    dotDir = "${config.home.homeDirectory}/.config/zsh";
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    history = {
      # 従来から使っている履歴ファイルをそのまま使う
      path = "${config.home.homeDirectory}/zsh_history";
      size = 10000;
      save = 10000;
      share = true;
      ignoreAllDups = true;
      ignoreSpace = true;
    };

    initContent = builtins.readFile ./zshrc;

    envExtra =
      if isLinux then
        ''
          if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
            . ~/.nix-profile/etc/profile.d/nix.sh
          fi
        ''
      else
        "";
  };
}
