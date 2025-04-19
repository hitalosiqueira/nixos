{
  programs.nixvim.plugins.lsp = {
    enable = true;

    servers = {
      bashls.enable = true;
      elixirls = {
        enable = true;
        rootDir = ''
          	  require('lspconfig').util.root_pattern("mix.exs")
          	'';
      };
      jsonls.enable = true;
      lua_ls.enable = true;
      terraformls.enable = true;
      nixd = {
        enable = true;
        settings = {
          formatting.command = [ "nixfmt" ];
        };
      };
      rust_analyzer = {
        installCargo = true;
        installRustc = true;
        enable = true;
      };
    };
  };
}
