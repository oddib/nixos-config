{
  pkgs,
  lib,
  ...
}: {
  services.printing = {
    drivers = with pkgs; [epson-escpr epsonscan2];
    browsing = true;
    browsedConf = ''
      BrowseDNSSDSubTypes _cups,_print
      BrowseLocalProtocols all
      BrowseRemoteProtocols all
      CreateIPPPrinterQueues All

      BrowseProtocols all
    '';
  };
  services.avahi = {
    nssmdns4 = lib.mkDefault true;
  };
}
