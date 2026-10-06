{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      settings.highlight.enable = true;
      settings.ensure_installed = [
        "go"
      ];
    };
    treesitter-context.enable = true;
  };

}
