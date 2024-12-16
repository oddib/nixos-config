{ ... }: {
  containers.caddy = {
    autoStart = true;
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";
    hostAddress6 = "fc00::1";
    localAddress6 = "fc00::2";
    config = { config, pkgs, lib, ... }: {

      services.caddy = {
        enable = true;
        package = (pkgs.callPackage /etc/caddy/custom-package.nix {
          plugins = [
            "github.com/caddyserver/ntlm-transport"
            "github.com/caddyserver/forwardproxy"
          ];
          vendorSha256 = "0000000000000000000000000000000000000000000000000000";
        });
      };

      system.stateVersion = "24,11";

      networking = {
        firewall = {
          enable = true;
          allowedTCPPorts = [ 80 443 ];
        };
        # Use systemd-resolved inside the container
        # Workaround for bug https://github.com/NixOS/nixpkgs/issues/162686
        useHostResolvConf = lib.mkForce false;
      };

      services.resolved.enable = true;
    };
  };
}
