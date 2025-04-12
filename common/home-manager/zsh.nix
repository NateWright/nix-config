{ config, pkgs, ... }:
{
  programs.thefuck = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    initExtra = ''
      bindkey '^ ' autosuggest-accept
    '';

    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "thefuck"
      ];
    };
    plugins = [
      {
        name = "TheOne";
        file = "zsh/TheOne.zsh-theme";
        src = pkgs.fetchFromGitHub {
          owner = "benniemosher";
          repo = "the-one-theme";
          rev = "2770641700b890a22452afa570a1b863433ed8d1";
          hash = "sha256-ZJ7PEn0CAK+JHW0cBjLdf0MXb7wouzNLmgx7xW3O6e8=";
        };
      }
    ];

  };
  programs.zellij.enableBashIntegration = false;
  programs.zellij.enableZshIntegration = false;
}
