# Git まわりの設定 (git / delta / gh)
{ pkgs, ... }:

let
  inherit (pkgs.stdenv) isDarwin;
in
{
  programs.gh.enable = true;

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user.email = "info@serizawa.me";
      user.name = "Yu SERIZAWA(@upamune)";
      alias = {
        cleanup = "!git branch --merged | grep  -v '\\*\\|main\\|develop' | xargs -n 1 -r git branch -d";
        prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
        root = "rev-parse --show-toplevel";
      };
      color.ui = true;
      core.askPass = "";
      credential.helper = if isDarwin then "osxkeychain" else "store";
      github.user = "upamune";
      push.default = "tracking";
      init.defaultBranch = "main";
    };
  };
}
