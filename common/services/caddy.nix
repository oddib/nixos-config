{ lib, pkgs, ... }: {
  ###
  # Caddy
  services.tailscaleAuth = {
    enable = true;
    user = "caddy";
    group = "caddy";
  };
  services.caddy = {
    enable = true;
    environmentFile = "/etc/caddy/caddy.env";
    logFormat = lib.mkForce "level DEBUG";
    package = pkgs.caddy.withPlugins {
      plugins = [
        "github.com/caddy-dns/cloudflare@v0.0.0-20240703190432-89f16b99c18e"
      ];
      hash = "sha256-kbTKCPjjIGRZZ550lBg0c5Ye4AK4o5yCRynBIvCLYkQ=";
    };
    globalConfig = ''
      acme_dns cloudflare {$CLOUDFLARE_API_KEY}
    '';
    extraConfig = ''
      (auth) {
          forward_auth unix//run/tailscale-nginx-auth/tailscale-nginx-auth.sock {
            uri /auth
            header_up Remote-Addr {remote_host}
            header_up Remote-Port {remote_port}
            header_up Original-URI {uri}
            copy_headers {
              Tailscale-User>X-Webauth-User
              Tailscale-Name>X-Webauth-Name
              Tailscale-Login>X-Webauth-Login
              Tailscale-Tailnet>X-Webauth-Tailnet
              Tailscale-Profile-Picture>X-Webauth-Profile-Picture
            }
          }
        }


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
      "radarr.{$DOMAIN}".extraConfig = ''
          route {
            import auth          
            @allowedUser {
                header X-Webauth-User "{$EMAIL}"
            }

            reverse_proxy @allowedUser http://localhost:7878
            respond "Access denied" 403
        }
      '';
      "sonarr.{$DOMAIN}".extraConfig = ''
          route {
            import auth          
            @allowedUser {
                header X-Webauth-User "{$EMAIL}"
            }

            reverse_proxy @allowedUser http://localhost:8989
            respond "Access denied" 403
        }
      '';
      "prowlarr.{$DOMAIN}".extraConfig = ''
          route {
            import auth          
            @allowedUser {
                header X-Webauth-User "{$EMAIL}"
            }

            reverse_proxy @allowedUser http://localhost:9696
            respond "Access denied" 403
        }
      '';
      "sabnzbd.{$DOMAIN}".extraConfig = ''
          route {
            import auth          
            @allowedUser {
                header X-Webauth-User "{$EMAIL}"
            }

            reverse_proxy @allowedUser http://localhost:4343
            respond "Access denied" 403
        }
      '';
    };
  };

  systemd.services.caddy.serviceConfig = {
    ProtectSystem = "strict";
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
    SystemCallFilter = "@system-service";
  };
}
