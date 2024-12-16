{ lib, ... }:

{
  virtualisation.oci-containers.containers."authelia" = {
    image = "docker.io/authelia/authelia:latest";
    environment = {
      "AUTHELIA_AUTHENTICATION_BACKEND_LDAP_PASSWORD_FILE" =
        "/run/secrets/AUTHELIA_AUTHENTICATION_BACKEND_LDAP_PASSWORD";
      "AUTHELIA_IDENTITY_VALIDATION_RESET_PASSWORD_JWT_SECRET_FILE" =
        "/run/secrets/JWT_SECRET";
      "AUTHELIA_NOTIFIER_SMTP_PASSWORD_FILE" = "/run/secrets/gmail-smtp";
      "AUTHELIA_SESSION_SECRET_FILE" = "/run/secrets/SESSION_SECRET";
      "AUTHELIA_STORAGE_ENCRYPTION_KEY_FILE" =
        "/run/secrets/STORAGE_ENCRYPTION_KEY";
      "AUTHELIA_STORAGE_POSTGRES_PASSWORD_FILE" =
        "/run/secrets/POSTGRES_AUTHELIA";
      "DOMAIN" = "scuffedflix.no";
      "FOLDER_FOR_CONFIGS" = "/home/oddbjornmr/docker";
      "FOLDER_FOR_MEDIA" = "/mnt/storage/media";
      "FOLDER_FOR_SECRETS" = "";
      "PGID" = "999";
      "PUID" = "999";
      "TIMEZONE" = "Europe/Oslo";
      "TP_THEME" = "nord";
      "UMASK" = "022";
    };
    log-driver = "journald";
    extraOptions = [ "--network-alias=authelia" "--network=default-network" ];
  };
  systemd.services."podman-authelia" = {
    serviceConfig = { Restart = lib.mkOverride 90 "always"; };
    after = [ "podman-network-default-network.service" ];
    requires = [ "podman-network-default-network.service" ];
    partOf = [ "podman-compose-scuffedflix-root.target" ];
    wantedBy = [ "podman-compose-scuffedflix-root.target" ];
  };
  virtualisation.oci-containers.containers."lldap" = {
    image = "lldap/lldap:stable";
    environment = {
      "DOMAIN" = "scuffedflix.no";
      "FOLDER_FOR_CONFIGS" = "/home/oddbjornmr/docker";
      "FOLDER_FOR_MEDIA" = "/mnt/storage/media";
      "FOLDER_FOR_SECRETS" = "";
      "GID" = "998";
      "LLDAP_DATABASE_URL_FILE" = "/run/secrets/LLDAP_DATABASE_URL";
      "LLDAP_JWT_SECRET_FILE" = "/run/secrets/LLDAP_JWT_SECRET";
      "LLDAP_KEY_SEED_FILE" = "/run/secrets/LLDAP_KEY_SEED";
      "LLDAP_LDAP_BASE_DN" = "dc=scuffedflix,dc=no";
      "LLDAP_LDAP_USER_PASS_FILE" = "/run/secrets/LLDAP_ADMIN_PASSWORD";
      "PGID" = "999";
      "PUID" = "999";
      "TIMEZONE" = "Europe/Oslo";
      "TP_THEME" = "nord";
      "TZ" = "Europe/Oslo";
      "UID" = "998";
      "UMASK" = "022";
    };
    volumes = [
      "/home/oddbjornmr/Dokumenter/Docker/Scuffedflix/Scuffedflix/auth/lldap_config.toml:/data/lldap_config.toml:rw"
      "/home/oddbjornmr/docker/lldap:/data:rw"
    ];
    log-driver = "journald";
    extraOptions = [ "--network-alias=lldap" "--network=default-network" ];
  };
  systemd.services."podman-lldap" = {
    serviceConfig = { Restart = lib.mkOverride 90 "no"; };
    after = [ "podman-network-default-network.service" ];
    requires = [ "podman-network-default-network.service" ];
    partOf = [ "podman-compose-scuffedflix-root.target" ];
    wantedBy = [ "podman-compose-scuffedflix-root.target" ];
  };
  virtualisation.oci-containers.containers."redis-stack" = {
    image = "redis/redis-stack:latest";
    environment = {
      "DOMAIN" = "scuffedflix.no";
      "FOLDER_FOR_CONFIGS" = "/home/oddbjornmr/docker";
      "FOLDER_FOR_MEDIA" = "/mnt/storage/media";
      "FOLDER_FOR_SECRETS" = "";
      "PGID" = "999";
      "PUID" = "999";
      "TIMEZONE" = "Europe/Oslo";
      "TP_THEME" = "nord";
      "UMASK" = "022";
    };
    log-driver = "journald";
    extraOptions = [ "--network-alias=redis" "--network=default-network" ];
  };
  systemd.services."podman-redis-stack" = {
    serviceConfig = { Restart = lib.mkOverride 90 "no"; };
    after = [ "podman-network-default-network.service" ];
    requires = [ "podman-network-default-network.service" ];
    partOf = [ "podman-compose-scuffedflix-root.target" ];
    wantedBy = [ "podman-compose-scuffedflix-root.target" ];
  };
}
