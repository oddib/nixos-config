{...}: {
  services.sunshine = {
    autoStart = true;
    capSysAdmin = true;
    openFirewall = true;
  };
}
