{
  flake.modules.homeManager.browser = {
    pkgs,
    lib,
    ...
  }: {
    home.packages = with pkgs;
      [
      ]
      ++ lib.optionals (
        stdenv.hostPlatform.isLinux
      ) [vivaldi]
      ++ lib.optionals (
        stdenv.hostPlatform.isDarwin
      ) [firefox];
  };
}
