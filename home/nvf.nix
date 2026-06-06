{ pkgs, lib, ... }:

let
  # ==========================================
  # Extracted Configuration Variables
  # ==========================================

  # Bulletproof Lua-driven motion bindings for Leap
  leapKeymaps = [
    {
      key = "s";
      mode = "n";
      action = "<cmd>lua require('leap').leap({ target_windows = { vim.api.nvim_get_current_win() } })<CR>";
      silent = true;
      desc = "Leap Forward/Targeted";
    }
    {
      key = "S";
      mode = "n";
      action = "<cmd>lua require('leap').leap({ backward = true, target_windows = { vim.api.nvim_get_current_win() } })<CR>";
      silent = true;
      desc = "Leap Backward";
    }
    {
      key = "gs";
      mode = "n";
      action = "<cmd>lua require('leap').leap({ target_windows = vim.tbl_filter(function(win) return vim.api.nvim_win_get_config(win).focusable end, vim.api.nvim_tabpage_list_wins(0)) })<CR>";
      silent = true;
      desc = "Leap From Window";
    }
  ];

  # Core utility and LSP bindings
  coreKeymaps = [
    {
      key = "<leader>e";
      mode = "n";
      action = ":NvimTreeToggle<CR>";
      silent = true;
      desc = "Toggle Tree";
    }
    {
      key = "-";
      mode = "n";
      action = ":Oil<CR>";
      silent = true;
      desc = "Open Oil (Edit FS)";
    }
    {
      key = "<leader>cf";
      mode = "n";
      action = ":lua vim.lsp.buf.format()<CR>";
      silent = true;
      desc = "LSP Format";
    }
    {
      key = "K";
      mode = "n";
      action = ":lua vim.lsp.buf.hover()<CR>";
      silent = true;
      desc = "Hover Documentation";
    }
    {
      key = "gd";
      mode = "n";
      action = ":lua vim.lsp.buf.definition()<CR>";
      silent = true;
      desc = "Go to Definition";
    }
    {
      key = "<leader>ca";
      mode = "n";
      action = ":lua vim.lsp.buf.code_action()<CR>";
      silent = true;
      desc = "Code Action";
    }
  ];

  # Custom Lua snippets for granular UI control
  uiTweaksLua = ''
    vim.g.mapleader = " "
    vim.opt.showcmd = true
    vim.opt.cursorline = true

    -- Cleaner diagnostic floating windows
    vim.diagnostic.config({
      virtual_text = { prefix = '●' },
      float = { border = "rounded" }
    })
  '';

in
{
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;
        preventJunkFiles = true;

        # System clipboard integration
        clipboard.registers.unnamedplus.enable = true;

        # ==========================================
        # Theme & UI
        # ==========================================
        theme = {
          enable = true;
          name = "catppuccin";
          style = "mocha";
          transparent = true;
        };

        # Hardening Noice dependencies
        ui = {
          borders.enable = true;
          fastaction.enable = true;
          smartcolumn = {
            enable = true;
            setupOpts.column = 80;
          };
          # FIX: Explicitly routing Noice commands and notifications
          noice = {
            enable = true;
          };
        };

        # Explicit notifications framework required by Noice
        notify.nvim-notify.enable = true;

        statusline.lualine.enable = true;

        # ==========================================
        # Languages & LSP
        # ==========================================
        lsp.enable = true;
        treesitter.enable = true;

        languages = {
          enableTreesitter = true;
          enableFormat = true;

          nix = {
            enable = true;
            format.type = [ "nixfmt" ];
            lsp.servers = [ "nixd" ];
          };

          rust = {
            enable = true;
            lsp.enable = true;
            dap.enable = true;
            extensions.crates-nvim.enable = true;
          };

          bash.enable = true;
          markdown.enable = true;
          lua.enable = true;
        };

        # ==========================================
        # Motion & Workflow
        # ==========================================
        utility.motion = {
          leap.enable = true;
        };

        autocomplete.nvim-cmp.enable = true;
        telescope.enable = true;

        filetree.nvimTree = {
          enable = true;
          setupOpts.view.side = "left";
        };

        terminal.toggleterm = {
          enable = true;
          setupOpts.direction = "horizontal";
        };

        # ==========================================
        # Plugins & Injection
        # ==========================================
        extraPackages = with pkgs; [
          nixfmt
          shfmt
        ];

        extraPlugins = with pkgs.vimPlugins; {
          oil = {
            package = oil-nvim;
            setup = "require('oil').setup()";
          };
        };

        # Injecting our fixed variables
        keymaps = coreKeymaps ++ leapKeymaps;
        luaConfigRC.nightkat01-ui = uiTweaksLua;
      };
    };
  };
}
