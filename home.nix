{ pkgs, lib, username, ... }:

{
  home.username = username;

  # https://github.com/LnL7/nix-darwin/issues/682
  home.homeDirectory = lib.mkForce "/Users/${username}";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  fonts.fontconfig.enable = true;

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # ".screenrc".source = dotfiles/screenrc;
  };

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.go
    pkgs.jq
    pkgs.ghq
    pkgs.devbox
    pkgs.uv
    pkgs.tig
    pkgs.lazygit
    pkgs.fontconfig
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
  programs.fzf.enable = true;
  programs.eza.enable = true;
  programs.bat.enable = true;
  programs.direnv.enable = true;
  programs.mise.enable = true;
  programs.neovim = {
    enable = true;
    withNodeJs = true;
    withPython3 = true;
    vimAlias = true;
  };
  programs.gh.enable = true;
  programs.git = {
    enable = true;
    userEmail = "info@serizawa.me";
    userName = "Yu SERIZAWA(@upamune)";
    delta.enable = true;
  };
  programs.starship = {
    enable = true;
  };
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    dotDir = ".config/zsh";
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    initExtra = (builtins.readFile ./zshrc);
    envExtra = ''
      if [ -e ~/.nix-profile/etc/profile.d/nix.sh ]; then
        . ~/.nix-profile/etc/profile.d/nix.sh
      fi
    '';
  };
  programs.zoxide.enable = true;
  programs.bun.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
