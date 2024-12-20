{  ... }: {
  programs._1password.enable = true;
  opnix = {
    # This is where you put your Service Account token in .env file format, e.g.
    # OP_SERVICE_ACCOUNT_TOKEN="{your token here}"
    # See: https://developer.1password.com/docs/service-accounts/use-with-1password-cli/#get-started
    # This file should have permissions 400 (file owner read only) or 600 (file owner read-write)
    # The systemd script will print a warning for you if it's not
    environmentFile = "/etc/opnix.env";
    # Set the systemd services that will use 1Password secrets; this makes them wait until
    # secrets are deployed before attempting to start the service.
    systemdWantedBy = [ "podman-caddy" ];
    # Specify the secrets you need
    secrets = {
      # The 1Password Secret Reference in here (the `op://` URI)
      # will get replaced with the actual secret at runtime
      caddy-secret.source = ''
        CLOUDFLARE_API_KEY=op://Docker secrets/CF-api/Section_zt7q7yv43v24wegeyewpaikbjy/api token
      '';
      # you can also specify the UNIX file owner, group, and mode
      caddy-secret.user = "root";
      caddy-secret.group = "root";
      caddy-secret.mode = "0600";
      # If you need to, you can even customize the path that the secret gets installed to
      #caddy-secret.path = "/run/secrets/container/caddy-secret";
      # You can also disable symlinking the secret into the installation destination
      caddy-secret.symlink = true;
    };
  };
}
