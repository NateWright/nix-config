{ ... }:
{
  programs.git = {
    enable = true;
    userEmail = "nathanwrightbusiness@gmail.com";
    userName = "Nathan Wright";
  };
  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };
}
