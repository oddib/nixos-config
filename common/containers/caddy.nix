{ config, ... }: {
  virtualisation.oci-containers.containers.caddy = {
    image = "ghcr.io/caddybuilds/caddy-cloudflare:latest";
    environmentFiles = [ config.opnix.secrets.caddy-secret.path ];
    environment = { DOMAIN = "scuffedflix.no"; };
    extraOptions = [ "--network=host" ];
    user = "root";
    volumes = [
      "/etc/container/caddy/Caddyfile:/etc/caddy/Caddyfile"
      "caddy_data:/data"
      "caddy_config:/config"
    ];
    capabilities = {
      NET_ADMIN = true;
    };
  };
  environment.etc = {
    caddy = {
      #source = ./Caddyfile;
      target = "/container/caddy/Caddyfile";
      text =
        "\n(cloudflare) {\n	tls {\n		dns cloudflare {$CLOUDFLARE_API_KEY}\n	}\n}\n{$DOMAIN} {\n	reverse_proxy localhost:8096\n	import cloudflare\n}\n*.{$DOMAIN} {\n	import cloudflare\n  @jellyseerr host jellyseerr.{$DOMAIN}, jellyserr.{$DOMAIN}, jellyseer.{$DOMAIN}, jellyser.{$DOMAIN}, request.{$DOMAIN} \n  handle @jellyseerr {\n    reverse_proxy localhost:5055\n  }\n  @wizarr host invite.{$DOMAIN}\n  handle @wizarr {\n    reverse_proxy localhost:5000\n  }\n}\n      ";
    };
  };
}
