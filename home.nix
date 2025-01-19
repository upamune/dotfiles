{
  pkgs,
  lib,
  username,
  ...
}:

let
  inherit (pkgs.stdenv) isDarwin isLinux;
in
{
  home.username = username;
  home.homeDirectory =
    if isDarwin then lib.mkForce "/Users/${username}" else lib.mkForce "/home/${username}";
  home.stateVersion = "24.05";

  fonts.fontconfig.enable = true;

  home.packages =
    with pkgs;
    [
      # Go
      go
      gopls
      # Git
      ghq
      lazygit
      tig
      # jujutsu
      jujutsu
      # Nix
      cachix
      devbox
      # Python
      uv
      # Container
      colima
      docker-client
      lazydocker
      # CLI
      _1password-cli
      asciinema
      google-cloud-sdk
      htop
      jq
      tldr
      # Fonts
      fontconfig
      nerd-fonts.fira-code
    ]
    ++ lib.optionals isDarwin [
      # macOS-specific packages
      tailscale
    ]
    ++ lib.optionals isLinux [
      # Linux-specific packages
      # Add any WSL-specific packages here
    ];

  programs = {
    fzf.enable = true;
    eza.enable = true;
    bat.enable = true;
    direnv.enable = true;

    neovim = {
      enable = true;
      withNodeJs = true;
      withPython3 = true;
    };

    gh.enable = true;

    git = {
      enable = true;
      userEmail = "info@serizawa.me";
      userName = "Yu SERIZAWA(@upamune)";
      delta.enable = true;
      aliases = {
        cleanup = "!git branch --merged | grep  -v '\\*\\|main\\|develop' | xargs -n 1 -r git branch -d";
        prettylog = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(r) %C(bold blue)<%an>%Creset' --abbrev-commit --date=relative";
        root = "rev-parse --show-toplevel";
      };
      extraConfig = {
        color.ui = true;
        core.askPass = ""; # needs to be empty to use terminal for ask pass
        credential.helper = if isDarwin then "osxkeychain" else "store"; # More secure for macOS
        github.user = "upamune";
        push.default = "tracking";
        init.defaultBranch = "main";
      };
    };

    starship = {
      enable = true;
      settings = import ./config/starship.nix;
    };

    zsh = {
      enable = true;
      defaultKeymap = "emacs";
      dotDir = ".config/zsh";
      syntaxHighlighting.enable = true;
      autosuggestion.enable = true;
      initExtra = builtins.readFile ./zshrc;
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

    atuin.enable = true;
    bun.enable = true;
    fd.enable = true;
    mise.enable = true;
    zoxide.enable = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
