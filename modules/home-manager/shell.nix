{ config, ... }:
{
  programs.zsh = {
    initExtra = ''
      [[ ! -f ~/.p10k.zsh ]] || source  ~/.p10k.zsh
      if command -v tmux >/dev/null 2>&1; then
        [ -z "$TMUX" ] && exec tmux new-session -A -s main
      fi
    '';
    enable = true;

    shellAliases = {
      update = "sudo nixos-rebuild switch --flake /home/hsiq/nixos#default";
    };

    zplug = {
      enable = true;
      plugins = [
        { name = "zsh-users/zsh-autosuggestions"; } # Simple plugin installation
        {
          name = "romkatv/powerlevel10k";
          tags = [
            "as:theme"
            "depth:1"
          ];
        } # Installations with additional options. For the list of options, please refer to Zplug README.
      ];
    };
    history.size = 1000000000;
  };

}
