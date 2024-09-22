{ pkgs, lib, username, ... }:

{
  home.username = username;

  # https://github.com/LnL7/nix-darwin/issues/682
  home.homeDirectory = lib.mkForce "/Users/${username}";

  home.stateVersion = "24.05"; # Please read the comment before changing.

  fonts.fontconfig.enable = true;

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    pkgs.fzf
    pkgs.ghq
    pkgs.devbox
    pkgs.uv
    pkgs.tig
    pkgs.fontconfig
    (pkgs.nerdfonts.override { fonts = [ "FiraCode" ]; })
  ];
  programs.mise.enable = true;
  programs.neovim.enable = true;
  programs.gh.enable = true;
  programs.git = {
    enable = true;
    userEmail = "info@serizawa.me";
    userName = "Yu SERIZAWA(@upamune)";
  };
  programs.starship = {
    enable = true;
  };
  programs.zsh = {
    enable = true;
    defaultKeymap = "emacs";
    dotDir = ".config/zsh";
    syntaxHighlighting.enable = true;
  };

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # ".screenrc".source = dotfiles/screenrc;
    ".zshrc".source = ./zshrc;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
