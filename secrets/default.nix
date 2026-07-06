{ inputs, pkgs, config, ... }: {

  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];

  home.packages = with pkgs; [
    age
    sops
    ssh-to-age
  ];

  sops = {
    defaultSopsFile = ./secrets.yaml;

    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    secrets = { };
  };
}
