{ pkgs, ... }: {
  programs.helix = {
    enable = true;
    defaultEditor = true;
    extraPackages = with pkgs; [
      marksman
      clang-tools
      nil
      gopls
      python311Packages.python-lsp-server
      marksman
      nixfmt-rfc-style
    ];
    # settings = { theme = "catppuccin_macchiato"; };
    languages = {
      language = [
        {
          name = "rust";
          auto-format = true;
        }
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
        }
        {
          name = "c";
          auto-format = true;
          formatter = {
            command = "${pkgs.clang-tools}/bin/clang-format";
            args = [ "--style=file" "--fallback-style" "LLVM" ];
          };
        }
        {
          name = "go";
          auto-format = true;
        }
        {
          name = "python";
          auto-format = true;
          language-servers = [ "pylsp" ];
        }
      ];
      language-server = {
        pylsp = {
          command = "${pkgs.python311Packages.python-lsp-server}/bin/pylsp";
          config = { provideFormatter = true; };
        };

        typescript-language-server = with pkgs.nodePackages; {
          command =
            "${typescript-language-server}/bin/typescript-language-server";
          args = [
            "--stdio"
            "--tsserver-path=${typescript}/lib/node_modules/typescript/lib"
          ];
        };
      };
    };
  };
}
