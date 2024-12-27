{ config, ... }: {
  ###
  # Caddy
  
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
        "
        (cloudflare) {
        	tls {
        		dns cloudflare {$CLOUDFLARE_API_KEY}
        	}
        }
        {$DOMAIN} {
        	reverse_proxy localhost:8096
        	import cloudflare
        }
        jellyseerr.{$DOMAIN}, jellyserr.{$DOMAIN}, jellyseer.{$DOMAIN}, jellyser.{$DOMAIN}, request.{$DOMAIN} {
            reverse_proxy localhost:5055
            import cloudflare
          }
        invite.{$DOMAIN} {
            reverse_proxy localhost:5690
            import cloudflare
        }
        auth.{$DOMAIN} {
          reverse_proxy localhost:3890
          import cloudflare
        }
        ";
    };
  };
}
