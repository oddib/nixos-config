{
  pkgs,
  ...
}: let
  allUsers = {
    oddbjornmr = {
      description = "Oddbjørn Mestad Rønnestad";
      groups = ["networkmanager" "wheel" "lpadmin"];
      shell = pkgs.bash;
      passwordFile = "/etc/passwords/oddbjornmr";
      useHM = true;
    };

    /*
       alice = {
      description = "Alice Example";
      groups = [ "wheel" ];
      shell = pkgs.fish;
      passwordFile = "/etc/passwords/alice";
      useHM = true;
    };
    */
  };
in {
  _module.args.allUsers = allUsers;
}
