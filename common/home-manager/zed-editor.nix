{ lib, ... }:
{
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"
      "Catppuccin"
    ];
    userSettings = {
      ui_font_size = 16;
      buffer_font_size = 16;
      format_on_save = "on";
      theme = {
        dark = lib.mkForce "Catppuccin Macchiato";
        mode = "system";
      };

      languages = {
        Nix = {
          language_servers = [
            "nixd"
            "!nil"
          ];
        };
        lsp = {
          nixd = {
            settings = {
              formatting = {
                # Which command you would like to do formatting
                command = [ "nixfmt" ];
              };
            };
          };
        };
      };
    };
  };
}
