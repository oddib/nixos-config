{
  pkgs,
  lib,
  ...
}: {
  services.printing = {
    drivers = with pkgs; [epson-escpr epsonscan2];
  };
  hardware.printers = {
    ensurePrinters = [
      {
        name = "Epson_ET-2865";
        location = "Heimen";
        deviceUri = "dnssd://EPSON%20ET-2860%20Series._ipp._tcp.local/?uuid=cfe92100-67c4-11d4-a45f-64c6d2c66b57";
        model = "epson-inkjet-printer-escpr/Epson-ET-2860_Series-epson-escpr-en.ppd";
        ppdOptions = {
          PageSize = "A4";
        };
      }
    ];
    ensureDefaultPrinter = "Epson_ET-2865";
  };

  services.avahi = {
    nssmdns4 = lib.mkDefault true;
  };
}
