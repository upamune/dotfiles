# 各種 CLI ツールの設定
{
  programs = {
    fzf = {
      enable = true;
      enableZshIntegration = true;
      defaultOptions = [
        "--bind ctrl-n:down,ctrl-p:up"
      ];
    };
    eza.enable = true;
    bat.enable = true;
    direnv.enable = true;

    neovim = {
      enable = true;
      withNodeJs = true;
      withPython3 = true;
      withRuby = false;
    };

    atuin.enable = true;
    bun.enable = true;
    fd.enable = true;
    zoxide.enable = true;
  };
}
