{ inputs, pkgs, ... }: {
  imports = [ inputs.foundryvtt.nixosModules.foundryvtt ];
  services.foundryvtt = {
    minifyStaticFiles = true;
    proxyPort = 443;
    proxySSL = true;
    upnp = false;
    package = inputs.foundryvtt.packages.${pkgs.system}.foundryvtt_12;
  };
  environment.persistence."/persist".directories = [ "/var/lib/foundryvtt" ];
  services.caddy.virtualHosts."foundryvtt.{$DOMAIN}".extraConfig = ''
    reverse_proxy localhost:30000
  '';
}
