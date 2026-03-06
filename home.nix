{ config, pkgs, lib, gitEnable, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "encodepanda";
  home.homeDirectory = "/Users/encodepanda";
  home.sessionVariables = {
    # For hunspell in Emacs
    DICPATH = "$HOME/.nix-profile/share/aspell";
    CARGO_HOME = "$HOME/.cargo/";
    RUSTUP_HOME = "$HOME/.rustup";
  };

  home.sessionPath = [
    "/usr/local/opt/libpq/bin"
    "$HOME/.cargo/bin"
    "$HOME/.cabal/bin"
    "$HOME/.ghcup/bin"
    "$HOME/mutable_node_modules/bin"
    "$HOME/.local/bin"
  ];

  # tmux
  # TODO enable plugins
  programs.tmux = {
    enable = true;
    clock24 = true;
  };

  # zsh
  programs.zsh = {
    enable = true;
    # this sources nix in the newly created .zshrc
    # . "~/.cargo/env"
    initContent = ''
      . ~/.nix-profile/etc/profile.d/nix.sh
      export LANG=en_US.UTF-8
      export LANGUAGE=en_US.UTF-8
      export LC_ALL=en_US.UTF-8

      eval "$(atuin init zsh)"

      export NVM_DIR="$HOME/.nvm"
      [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
      [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
    '';

    autosuggestion.enable = true;
    history.extended = true;
    shellAliases = {
      nhn = "nix-shell -p cookiecutter git --run 'cookiecutter gh:EncodePanda/haskell-starter-kit'";
      ll = "ls -l";
      ".." = "cd ..";
      hms = "home-manager switch --flake ~/projects/h#\"encodepanda@$(uname -m | sed 's/arm64/aarch64/')-darwin\"";
      hmswg = "home-manager switch --flake ~/projects/h#\"encodepanda@$(uname -m | sed 's/arm64/aarch64/')-darwin-withgit\"";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "cabal"
        "git"
        "git-prompt"
        "gitignore"
        "copyfile"
        "aliases"
      ];
      theme = "candy";
    };
    loginExtra = ''
      bindkey '^R' history-incremental-pattern-search-backward
      bindkey '^F' history-incremental-pattern-search-forward
    '';
  };

  home.activation.installNvm = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "$HOME/.nvm" ]; then
      echo "Installing nvm to $HOME/.nvm"
      ${pkgs.curl}/bin/curl -fsSL https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh \
        | PROFILE=/dev/null bash
    fi
  '';

  # notifications when long running command is finished
  # e.g noti -s cabal build
  programs.noti = {
    enable = true;
    settings = {
      say = {
        voice = "Alex";
      };
    };
  };

  # direnv
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.htop = {
    enable = true;
  };

  # jq
  programs.jq.enable = true;

  # bat is just better cat
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
    };
  };
  # git with initial configuration
  programs.git = lib.mkIf gitEnable {
    enable = true;
    settings = {
       user.email = "paul.szulc@gmail.com";
       user.name = "EncodePanda";
    };
    ignores = [ "*~" ];
  };

  # enable autojump https://github.com/wting/autojump
  programs.autojump = {
    enable = true;
    enableZshIntegration = true;
  };

  home.packages = [
    # silver search (ag) is used by Emacs to grep files quickly
    pkgs.silver-searcher
    # ispell is a dictionary software, works nicely with Emacs
    # TODO open PR with ispell in home-manager with ability to
    # select dictionaries
    pkgs.ispell
    # nix files formatters
    pkgs.nixpkgs-fmt # works nicely with Emacs
    pkgs.termshark
    # pandoc to convert between different text formats
    pkgs.pandoc
    # ripgrep is a line-oriented search tool that recursively
    # searches your current directory for a regex pattern
    pkgs.ripgrep
    # fswatch is a file change monitor
    pkgs.fswatch
    # entr - Run arbitrary commands when files change
    # docs http://eradman.com/entrproject/
    pkgs.entr
    # nix-prefetch-git for things like following:
    # https://input-output-hk.github.io/haskell.nix/tutorials/source-repository-hashes/
    pkgs.nix-prefetch-git
    # look at nix dependencies
    pkgs.nix-tree
    # plantuml
    pkgs.plantuml
    # yt-dlp allows to download youtube videos
    pkgs.yt-dlp
    # graphviz
    pkgs.graphviz
    # niv
    pkgs.niv
    # gnuplot for plotting images from the command line
    pkgs.gnuplot
    # cookiecutter for templates like EncodePanda/haskell-starter-kit
    pkgs.cookiecutter
    # Pipe your nix-build output through the nix-output-monitor (aka nom) to get
    # additional information while building.
    pkgs.nix-output-monitor
    # coq
    pkgs.coq
    # p7zip
    pkgs.p7zip
    # gls because Emacs :shrug:
    pkgs.coreutils
    # task juggler
    pkgs.taskjuggler
    # large files
    pkgs.git-lfs
    # absorbs fixups into a commit
    pkgs.git-absorb
    pkgs.nix-du
    # https://github.com/theZiz/aha
    pkgs.aha
    pkgs.asciinema
    pkgs.nmap
    pkgs.postgresql
    pkgs.wget
    pkgs.scala
    pkgs.atuin
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "25.11";
}
