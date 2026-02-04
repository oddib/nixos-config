{
  flake.modules.nixos.foundryvtt = {
    inputs,
    pkgs,
    ...
  }: {
    services.foundryvtt = {
      enable = true;
      hostName = "foundryvtt.scuffedflix.no";
      world = "Eberron";
      minifyStaticFiles = true;
      proxyPort = 443;
      proxySSL = true;
      upnp = false;
      package = inputs.foundryvtt.packages.${pkgs.stdenv.hostPlatform.system}.foundryvtt_13;
    };
    environment.persistence."/persist".directories = ["/var/lib/foundryvtt"];
    services.caddy.virtualHosts."foundryvtt.{$DOMAIN}".extraConfig = ''
      reverse_proxy localhost:30000
    '';
  };
}
