{
  inputs,
  pkgs,
  ...
}:
{

  imports = [
    inputs.sops-nix.nixosModules.sops
    ./vault-certs.nix
  ];

  environment.systemPackages = with pkgs; [
    age
    sops
    ssh-to-age
  ];

  sops = {
    defaultSopsFile = ./secrets.yaml;

    age.keyFile = "/var/lib/sops-nix/key.txt";

    secrets.ca-key = {
      owner = "root";
      group = "root";
      mode = "0400";
    };
  };
}
