{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      (vivaldi.override {
        proprietaryCodecs = true;
        enableWidevine = true;
      })
    ];
}
