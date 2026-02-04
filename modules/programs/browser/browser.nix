{
  flake.modules.homeManager.browser =
    {
      pkgs,
      lib,
      ...
    }:
    {
      home.packages =
        with pkgs;
        [
          
        ]
        ++ lib.optionals (
          stdenv.hostPlatform.system == "x86_64-linux"
          || stdenv.hostPlatform.system == "aarch64-linux"
        ) [ vivaldi ]
        ++ lib.optionals (
          stdenv.hostPlatform.system == "aarch64-darwin"
          || stdenv.hostPlatform.system == "x86_64-darwin"
        ) [ firefox ];
    };
}