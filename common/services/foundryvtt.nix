{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.foundryvtt.nixosModules.foundryvtt];
  services.foundryvtt = {
    hostName = "foundryvtt.scuffedflix.no";
    world = "Eberron";
    minifyStaticFiles = true;
    proxyPort = 443;
    proxySSL = true;
    upnp = false;
    package = inputs.foundryvtt.packages.${pkgs.system}.foundryvtt_12;
  };
  services.caddy.virtualHosts."foundryvtt.{$DOMAIN}".extraConfig = ''
    handle_path /join* {
      import auth
      route {
        @tailscaleUser header X-Webauth-User *
        handle @tailscaleUser {
          route {
          {file./etc/caddy/users.json}
            exec map_user "${pkgs.jq.bin}/bin/jq -r --arg ts "$1" '.users[] | select(.tailscale_id == $ts) | .foundry_id' /etc/caddy/users.json {http.header.X-Webauth-User}
              output foundry_id
            }
            rewrite * /join {
             method POST
             header Content-Type "application/json"
             request_body "{http.exec.map_user.foundry_id}&password="
            }
            reverse_proxy localhost:30000 {
             header_down +Set-Cookie session=*
            }
            header Set-Cookie "{http.reverse_proxy.header.Set-Cookie}; Secure; HttpOnly; SameSite=Lax"
            redir /game 302
          }
        }
        respond "Access denied" 403
        }

      }
    }
    handle * {
      @hasValidSession header Cookie session=*
      handle @hasValidSession {
        reverse_proxy localhost:30000
      }
      reverse_proxy localhost:30000
      #redir /join 302
    }

    respond "Missing Tailscale authentication" 403

  '';
}
