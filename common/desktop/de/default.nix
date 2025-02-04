{ ... }:

{
  imports = [ 
	./cosmic.nix 
	./gnome.nix 
	./audio.nix];
   # Configure keymap
  services.xserver.xkb = {
    layout = "no";
    variant = "";
  };

}
