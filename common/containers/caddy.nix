{ config, ... }: {
  virtualisation.oci-containers.containers.caddy = {
    image = "ghcr.io/caddybuilds/caddy-cloudflare:latest";
    environmentFiles = [config.opnix.secrets.caddy-secret.path];
    environment = {
      DOMAIN = "scuffedflix.no";};
    extraOptions = [ "--network=host" ];
    user= "root";
    volumes = [
      "/etc/container/caddy/Caddyfile:/etc/caddy/Caddyfile"
      "caddy_data:/data"
      "caddy_config:/config"
    ];
    #capabilities = {
    #  NET_ADMIN = true;
    #};
  };
  environment.etc = {
    caddy = {
      #source = ./Caddyfile;
      target = "/container/caddy/Caddyfile";
      text ="
(cloudflare) {
	tls {
		dns cloudflare {$CLOUDFLARE_API_KEY}
	}
}
{$DOMAIN} {
	reverse_proxy localhost:8096
	import cloudflare
}
*.{$DOMAIN} {
	import cloudflare
    @test host test.{$DOMAIN}

    @jellyseerr host jellyseerr.{$DOMAIN}, jellyserr.{$DOMAIN}, jellyseer.{$DOMAIN}, jellyser.{$DOMAIN}, request.{$DOMAIN} 
    handle @jellyseerr {
        reverse_proxy localhost:5055
    }
}
      ";
    };
  };
}
