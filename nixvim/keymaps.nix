{
  programs.nixvim = {
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    plugins.lsp.keymaps = {
      lspBuf = {
        "gD" = "declaration";
        "gd" = "definition";
        "gi" = "implementation";
        "gr" = "references";
        "K" = "hover";
        "<leader>k" = "signature_help";
        "<leader>ca" = "code_action";
        "<space>rn" = "rename";
      };
    };

    keymaps = [
      {
        action.__raw = "vim.diagnostic.goto_prev";
        key = "[d";
        options.desc = "Previous diagnostic";
      }
      {
        action.__raw = "vim.diagnostic.goto_next";
        key = "]d";
        options.desc = "Previous diagnostic";
      }
      {
        action = ":w<cr>:TestSuite";
        key = "<leader>ts";
        options.desc = "Test suite";
      }
      {
        action = ":w<cr>:TestLast";
        key = "<leader>tr";
        options.desc = "Repeat last test run";
      }
      {
        action = ":w<cr>:TestNearest";
        key = "<leader>tt";
        options.desc = "Test nearest";
      }
      {
        action = ":w<cr>:TestFile";
        key = "<leader>tf";
        options.desc = "Test file";
      }
      {
        action = ":TmuxNavigateLeft<cr>";
        key = "<c-h>";
        options.desc = "Navigate left";
      }
      {
        action = ":TmuxNavigateRight<cr>";
        key = "<c-l>";
        options.desc = "Navigate right";
      }
      {
        action = ":TmuxNavigateUp<cr>";
        key = "<c-k>";
        options.desc = "Navigate up";
      }
      {
        action = ":TmuxNavigateDown<cr>";
        key = "<c-j>";
        options.desc = "Navigate down";
      }
      {
        action = ":Telescope find_files<cr>";
        key = "<leader>sf";
        options.desc = "Search files";
      }
      {
        action = ":Telescope grep_string<cr>";
        key = "<leader>a";
        options.desc = "Grep string under cursor";
      }
      {
        action = ":Telescope live_grep<cr>";
        key = "<leader>sw";
        options.desc = "Search text or pattern";
      }
      {
        action = ":Telescope buffers<cr>";
        key = "<leader>sb";
        options.desc = "Search buffers";
      }
      {
        action = ":Telescope help_tags<cr>";
        key = "<leader>sh";
        options.desc = "Search help";
      }
      {
        action = ":Telescope old_files<cr>";
        key = "<leader>so";
        options.desc = "Search recent files";
      }
      {
        action = ":Telescope commands<cr>";
        key = "<leader>sc";
        options.desc = "Search commands";
      }
      {
        action = "<C-u>zz";
        key = "<C-u>";
        options = {
          silent = false;
        };
      }
      {
        action = "<C-d>zz";
        key = "<C-d>";
        options = {
          silent = false;
        };
      }
      {
        action = "${"[[\"_dP]]"}";
        key = "<leader>p";
        options = {
          silent = false;
        };
        mode = "x";
      }
      {
        action = "${"[[\"+Y]]"}";
        key = "<leader>Y";
        options = {
          silent = false;
        };
      }
      {
        action = "${"[[\"+y]]"}";
        key = "<leader>y";
        options = {
          silent = false;
        };
      }
    ];
  };
}
