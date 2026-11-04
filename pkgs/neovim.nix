{ lib, ... }:
{
  config.vim = {
    keymaps = [
      {
        key = "<leader>uf";
        mode = "n";
        desc = "Toggle format on save";
        action = "<cmd>lua vim.b.disable_autoformat = not vim.b.disable_autoformat; print(vim.b.disable_autoformat and 'Formatting disabled' or 'Formatting enabled')<CR>";
      }
    ];
    formatter.conform-nvim = {
      enable = true;

      setupOpts.format_on_save = lib.generators.mkLuaInline ''
        function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end

          return {
            timeout_ms = 500,
            lsp_format = "fallback",
          }
        end
      '';
    };
    theme = {
      enable = true;
      name = "gruvbox";
      style = "dark";
    };

    undoFile.enable = true;
    options = {
      exrc = true;
      secure = true;
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
    diagnostics = {
      enable = true;
      config.virtual_lines = true;
    };
    statusline.lualine.enable = true;
    telescope.enable = true;
    autocomplete.nvim-cmp.enable = true;
    autopairs.nvim-autopairs.enable = true;

    lsp = {
      enable = true;
      formatOnSave = false;
    };
    languages = {
      enableFormat = true;
      enableTreesitter = true;

      #languages
      nix = {
        enable = true;
        extraDiagnostics.enable = true;
        format.type = [ "nixfmt" ];
      };
      rust.enable = true;
      markdown.enable = true;
      python.enable = true;
      lua.enable = true;
      go.enable = true;
      yaml.enable = true;
      terraform.enable = true;
      bash.enable = true;
    };
    viAlias = true;
    vimAlias = true;
    spellcheck = {
      enable = true;
      languages = [ "en" ];
    };
    utility = {

      undotree.enable = true;
      yazi-nvim.enable = true;
    };

  };
}
