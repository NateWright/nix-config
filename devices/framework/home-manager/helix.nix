{ lib, config, pkgs, ... }: {
  programs.helix = {
    enable = true;
    extraPackages = with pkgs; [ marksman clang-tools nil ];
    settings = { theme = "onedark"; };
    languages = {

      language-server.typescript-language-server = with pkgs.nodePackages; {
        command =
          "${typescript-language-server}/bin/typescript-language-server";
        args = [
          "--stdio"
          "--tsserver-path=${typescript}/lib/node_modules/typescript/lib"
        ];
      };

      language = [
        {
          name = "rust";
          auto-format = true;
        }
        {
          name = "nix";
          auto-format = true;
          formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
        }
        {
          name = "c";
          auto-format = true;
          formatter.command = "${pkgs.clang-tools}/bin/clang-format";
        }
      ];
    };
  };
}
