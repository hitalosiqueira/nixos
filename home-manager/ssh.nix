{

  services.ssh-agent.enable = true;

  programs.ssh.settings = {
    github = {
      addKeysToAgent = "yes";
      hostname = "github.com";
      user = "git";
      identityFile = "~/.ssh/id_ed25519";
    };
  };
}
