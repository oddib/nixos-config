{ pkgs, ... }: {
  ###
  # Caddy
  services.caddy = {
    enable = true;
    environmentFile = "/etc/caddy/caddy.env";
    package = pkgs.caddy.withPlugins {
      plugins = [
        "github.com/caddy-dns/cloudflare@v0.0.0-20240703190432-89f16b99c18e"
      ];
      hash = "sha256-JVkUkDKdat4aALJHQCq1zorJivVCdyBT+7UhqTvaFLw=";
    };
    globalConfig = ''
      acme_dns cloudflare {$CLOUDFLARE_API_KEY}
    '';
    virtualHosts = {
      "{$DOMAIN}".extraConfig = ''
        reverse_proxy localhost:8096
      '';
      "jellyseerr.{$DOMAIN}" = {
        serverAliases = [
          "jellyserr.{$DOMAIN}"
          "jellyseer.{$DOMAIN}"
          "jellyser.{$DOMAIN}"
          "request.{$DOMAIN}"
        ];
        extraConfig = ''
          reverse_proxy localhost:5055
        '';
      };
      "invite.{$DOMAIN}".extraConfig = ''
        reverse_proxy localhost:5690
      '';
      "foundryvtt.{$DOMAIN}".extraConfig = ''
        reverse_proxy localhost:30000
      '';
      "nixcache.{$DOMAIN}".extraConfig = ''
        reverse_proxy localhost:8081
      '';
    };
  };

  systemd.services.caddy.serviceConfig = {
    ProtectSystem = "strict";
    InaccessiblePaths = "...";
    ProtectHome = true;
    PrivateTmp = true;
    ProtectProc = "invisible";
    ProtectKernelTunables = true;
    ProtectControlGroups = true;
    AmbientCapabilities = "cap_net_bind_service";
    CapabilityBoundingSet = "cap_net_bind_service";
    UMask = 77;
    #ProtectHostname = true;
    RestrictSUIDSGID = true;
    #ProtectClock = true;
    #ProtectKernelModules= true;
    #PrivateUsers=true;
    SystemCallFilter="@system-service";
  };
  # virtualisation.oci-containers.containers.caddy = {
  #   image = "ghcr.io/caddybuilds/caddy-cloudflare:latest";
  #   environmentFiles = [ "/etc/caddy" ];
  #   environment = { DOMAIN = "scuffedflix.no"; };
  #   extraOptions = [ "--network=host" ];
  #   user = "root";
  #   volumes = [
  #     "/etc/container/caddy/Caddyfile:/etc/caddy/Caddyfile"
  #     "caddy_data:/data"
  #     "caddy_config:/config"
  #   ];
  #   capabilities = { NET_ADMIN = true; };
  # };
  # environment.etc = {
  #   caddy = {
  #     #source = ./Caddyfile;
  #     target = "/container/caddy/Caddyfile";
  #     text = ''
  #       (cloudflare) {
  #       	tls {
  #       		dns cloudflare {$CLOUDFLARE_API_KEY}
  #       	}
  #       }
  #       {$DOMAIN} {
  #       	reverse_proxy localhost:8096
  #       	import cloudflare
  #       }
  #       jellyseerr.{$DOMAIN}, jellyserr.{$DOMAIN}, jellyseer.{$DOMAIN}, jellyser.{$DOMAIN}, request.{$DOMAIN} {
  #           reverse_proxy localhost:5055
  #           import cloudflare
  #         }
  #       invite.{$DOMAIN} {
  #           reverse_proxy localhost:5690
  #           import cloudflare
  #       }
  #       auth.{$DOMAIN} {
  #         reverse_proxy localhost:3890
  #         import cloudflare
  #       }
  #       foundryvtt.{$DOMAIN} {
  #         reverse_proxy localhost:30000
  #         import cloudflare
  #       }
  #       nixcache.{$DOMAIN} {
  #         reverse_proxy localhost:8081
  #         import cloudflare
  #       }
  #     '';
  #   };
  # };
}
