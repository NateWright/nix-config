{ config, pkgs, ... }:
let
  # icomoon-feather = pkgs.callPackage ./icomoon-feather/default.nix { };
  cascadia-code = pkgs.callPackage ./cascadia-code/default.nix { };
in
{
  fonts.fontDir.enable = true;
  fonts.fonts = with pkgs; [
    dotcolon-fonts
    (nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" "FiraMono" "FiraCode" "FantasqueSansMono" "JetBrainsMono" "Iosevka" "IosevkaTerm" ]; })
    inter
    noto-fonts
    noto-fonts-emoji
    comfortaa
    jetbrains-mono
    iosevka
    source-code-pro
    # icomoon-feather
    comfortaa
    cascadia-code
  ];
}
