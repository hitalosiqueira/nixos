{
  programs.nixvim.plugins.lsp = {
    enable = true;

    servers = {
      gopls.enable = true;
      bashls.enable = true;
      jsonls.enable = true;
      lua_ls.enable = true;
      nixd = {
        enable = true;
        settings = {
          formatting.command = [ "nixfmt" ];
        };
      };
    };
  };
}
