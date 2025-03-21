{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.foundryvtt.nixosModules.foundryvtt];
  services.foundryvtt = {
    hostname = "foundryvtt.scuffedflix.no";
    world= "Eberron";
    minifyStaticFiles = true;
    proxyPort = 443;
    proxySSL = true;
    upnp = false;
    package = inputs.foundryvtt.packages.${pkgs.system}.foundryvtt_12;
  };
  services.caddy.virtualHosts."foundryvtt.{$DOMAIN}".extraConfig = ''
    reverse_proxy localhost:30000
  '';
}
