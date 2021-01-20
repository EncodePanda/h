{ config, pkgs, ... }:

{
  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "encodepanda";
  home.homeDirectory = "/Users/encodepanda";

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
    initExtra = ''
      . ~/.nix-profile/etc/profile.d/nix.sh
    '';
    enableAutosuggestions = true;
    history.extended = true;
    shellAliases = {
      nhn = "nix-shell -p cookiecutter git --run 'cookiecutter gh:EncodePanda/haskell-starter-kit'";
      ll = "ls -l";
      ".." = "cd ..";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "cabal"
      ];
      theme = "half-life";
    };
    loginExtra = ''
      bindkey '^R' history-incremental-pattern-search-backward
      bindkey '^F' history-incremental-pattern-search-forward
    '';
  };

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
  };

  programs.htop = {
    enable = true;
    fields = [
      "PID"
      "PERCENT_CPU"
      "PERCENT_MEM"
      "TIME"
      "PRIORITY"
      "NICE"
      "M_SIZE"
      "M_RESIDENT"
      "M_SHARE"
      "STATE"
      "COMM"
    ];
    sortKey = "COMM";
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

  # git with initial configration:wq
  programs.git = {
    enable = true;
    userName = "EncodePanda";
    userEmail = "paul.szulc@gmail.com";
    ignores = [ "*~" ];
  };

  programs.emacs = {
    enable = true;
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
    # nix files formatter, works nicely with Emacs
    pkgs.nixpkgs-fmt
    # gh support in home-manager is broken
    # https://github.com/nix-community/home-manager/issues/1654
    # thus I had to use home.packages approach
    pkgs.gitAndTools.gh
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "21.03";
}
