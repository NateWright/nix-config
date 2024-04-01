{ lib, config, pkgs, ... }: {
  programs.nixvim = {
    enable = true;

    opts = {
      number = true;
      relativenumber = true;
      incsearch = true;
    };

    colorschemes = { gruvbox.enable = true; };

    plugins = {
      telescope.enable = true;
      harpoon = {
        enable = true;
        keymaps.addFile = "<leader>a";
      };
    };
  };
}
