{
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./autocmds.nix
    ./completions.nix
    ./keymaps.nix
    ./lsp.nix
    ./treesitter.nix
    ./vim-test.nix
    inputs.nixvim.homeManagerModules.nixvim
  ];

  home.packages = with pkgs; [
    nixfmt-rfc-style
    ripgrep
    fd
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    colorschemes = {
      catppuccin = {
        enable = true;
        autoLoad = true;
      };
    };

    plugins = {
      commentary.enable = true;
      fidget.enable = true;
      fugitive.enable = true;
      tmux-navigator.enable = true;
      gitsigns = {
        enable = true;
        settings = {
          current_line_blame = true;
        };
      };
      nvim-surround.enable = true;
      telescope.enable = true;
      undotree.enable = true;
      web-devicons.enable = true;
      which-key.enable = true;
    };

    opts = {
      relativenumber = true;
      incsearch = true;
      swapfile = false;
      backup = false;
      wrap = false;
      smartindent = true;
      tabstop = 2;
      softtabstop = 2;
      shiftwidth = 2;
      expandtab = true;
      hlsearch = false;
      termguicolors = true;
      background = "dark";
      signcolumn = "yes";
      scrolloff = 8;
      colorcolumn = "80";
      undofile = true;
    };

    extraConfigLua = ''
      vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
    '';

    extraPlugins = with pkgs.vimPlugins; [
      vim-gnupg
      vim-repeat
      vim-rhubarb
      vim-unimpaired
      mini-icons
    ];
  };
}
