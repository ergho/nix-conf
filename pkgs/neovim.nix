{
  vim = {
    theme = {
      enable = true;
      name = "gruvbox";
      style = "dark";
    };

    undoFile.enable = true;
    options = {
      shiftwidth = 2;
      tabstop = 2;
      softtabstop = 2;
      nu = true;
      relativenumber = true;
      wrap = false;
      expandtab = true;
      swapfile = false;
      backup = false;
      smartindent = true;
      hlsearch = false;
      incsearch = true;
      termguicolors = true;
      showmatch = true;
      scrolloff = 8;
      signcolumn = "yes";
      updatetime = 50;
    };
    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;
    autopairs.nvim-autopairs.enable = true;

    lsp = {
      enable = true;
      formatOnSave = true;
    };
    languages = {
      enableFormat = true;
      enableTreesitter = true;

      #languages
      nix = {
        enable = true;
        extraDiagnostics.enable = true;
        format.type = "nixfmt";
      };
      rust.enable = true;
      markdown.enable = true;
      python.enable = true;
      lua.enable = true;
      go.enable = true;
      yaml.enable = true;
    };
    viAlias = true;
    vimAlias = true;
    spellcheck = {
      enable = true;
      languages = [ "en" ];
    };
  };
}
