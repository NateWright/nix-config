{ ... }:
{
  programs.git = {
    enable = true;
    settings = {
      user = {
        email = "nathanwrightbusiness@gmail.com";
        name = "Nathan Wright";
      };
    };
  };
  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };
}
