{
  pkgs,
  config,
  lib,
  ...
}:
{

  home.packages = with pkgs; [
    sshfs
  ];

  services.ssh-agent.enable = true;

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
    matchBlocks = {
      "vmlab" = {
        hostname = "127.0.0.1";
        user = "hsiq";
        port = 2222;
        identityFile = "~/.ssh/id_rsa"; # optional if you're using a key
        forwardAgent = true;
      };
    };
  };

  home.activation.createWorkspaceDir = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    mkdir -p "${config.home.homeDirectory}/workspace/server"
  '';


}
