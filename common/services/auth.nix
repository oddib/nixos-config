{...}: {
  services.tsidp = {
    enable = false;
    localPort = 7979;
    port = 4343;
    useLocalTailscaled = true;
  };
  # services.caddy.virtualHosts."auth.{$DOMAIN}".extraConfig = ''
  #   reverse_proxy localhost:7979
  # '';
  services.caddy.extraConfig = ''
    (auth) {
      forward_auth unix//run/tailscale-nginx-auth/tailscale-nginx-auth.sock {
        uri /tsauth
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
}
