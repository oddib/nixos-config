{
  flake.modules.nixos.homeassistant = {...}: {
    services.home-assistant = {
      enable = true;
      extraComponents = [
        "analytics"
        "google_translate"
        "met"
        "radio_browser"
        "shopping_list"
        #...
        # Components required to operate a matter-over-thread
        # network with home-assistant
        "matter"
        "otbr"
        "thread"
        #...
      ];
    };
    services.matter-server.enable = true;
  };
}
