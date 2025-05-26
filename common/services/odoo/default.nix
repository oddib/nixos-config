{pkgs, ...}: {
  services.odoo = {
    #enable = true;
    # install addons declaratively.
    addons = [];
    # add the demo database
    autoInit = true;
    settings = {
      options = {
        db_user = "odoo";
        db_password = "odoo";
      };
    };
  };
  services.caddy.virtualHosts."scuffedflix.wild-manta.ts.net".extraConfig = ''
    reverse_proxy localhost:8069
  '';
}
