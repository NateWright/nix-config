{ lib, config, pkgs, ... }: {
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      jnoortheen.nix-ide
      pkief.material-icon-theme
      pkief.material-product-icons
      ms-vscode.cpptools-extension-pack
      ms-vscode.cpptools
      ms-vsliveshare.vsliveshare
      github.copilot
      streetsidesoftware.code-spell-checker
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "poptheme";
        publisher = "ArtisanByteCrafter";
        version = "1.0.4";
        sha256 = "sha256-GXLG4ojoBTvx6EpskEA3UhXXLKrCAGeRhjMgcl5pRog=";
      }
    ];
    userSettings = {
      "editor.formatOnSave" = true;
      "workbench.colorTheme" = "Pop Dark";
      "workbench.productIconTheme" = "material-product-icons";
      "workbench.iconTheme" = "material-icon-theme";
      "C_Cpp.clang_format_fallbackStyle" = "{ BasedOnStyle: Google, IndentWidth: 4, TabWidth: 4, ColumnLimit: 0}";
      "git.confirmSync" = false;
      "window.titleBarStyle" = "custom";
      "window.zoomLevel" = 1;
    };

  };
}
