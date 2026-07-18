{ config, pkgs, ... }:
let
  opensslConfig = pkgs.writeText "vault.cnf" ''
    [req]
    prompt = no
    distinguished_name = req_dn
    req_extensions = req_ext

    [req_dn]
    CN = vault.local

    [req_ext]
    subjectAltName = @alt_names
    extendedKeyUsage = serverAuth

    [alt_names]
    DNS.1 = vault.local
  '';
  generateVaultCert = pkgs.writeShellApplication {
    name = "generate-vault-cert";

    runtimeInputs = [
      pkgs.openssl
      pkgs.coreutils
    ];

    text = ''
      set -euxo pipefail

      CERTDIR=/var/lib/caddy/certs

      mkdir -p "$CERTDIR"

      if [ -s "$CERTDIR/vault.local.crt" ]; then
        if openssl x509 -checkend 2592000 \
            -noout \
            -in "$CERTDIR/vault.local.crt"; then
           exit 0
        fi
      fi

      openssl genrsa \
        -out "$CERTDIR/vault.local.key" \
        2048

      openssl req \
        -new \
        -key "$CERTDIR/vault.local.key" \
        -out "$CERTDIR/vault.local.csr" \
        -config ${opensslConfig}

      # openssl x509 \
      #   -req \
      #   -copy_extensions copy \
      #   -CA ${./certs/ca.crt} \
      #   -CAkey ${config.sops.secrets.ca-key.path} \
      #   -CAcreateserial \
      #   -CAserial "$CERTDIR/ca.srl" \
      #   -in "$CERTDIR/vault.local.csr" \
      #   -out "$CERTDIR/vault.local.crt" \
      #   -days 825

      openssl x509 \
        -req \
        -in "$CERTDIR/vault.local.csr" \
        -CA ${./certs/ca.crt} \
        -CAkey ${config.sops.secrets.ca-key.path} \
        -CAcreateserial \
        -CAserial "$CERTDIR/ca.srl" \
        -out "$CERTDIR/vault.local.crt" \
        -days 825 \
        -extfile ${opensslConfig} \
        -extensions req_ext

      chown root:caddy "$CERTDIR/vault.local.key"
      chmod 640 "$CERTDIR/vault.local.key"

      chown root:root "$CERTDIR/vault.local.crt"
      chmod 644 "$CERTDIR/vault.local.crt"
    '';
  };
in
{
  systemd.tmpfiles.rules = [
    "d /var/lib/caddy/certs 0750 caddy caddy -"
  ];
  systemd.services.generate-vault-cert = {
    description = "Generate Vaultwarden TLS certificate";

    before = [ "caddy.service" ];
    wantedBy = [ "caddy.service" ];

    serviceConfig.Type = "oneshot";

    script = "${generateVaultCert}/bin/generate-vault-cert";
  };
}
