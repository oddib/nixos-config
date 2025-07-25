{
  osConfig,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf osConfig.system.desktop.enable {
    home.packages = with pkgs; [
      firefox ## Firefox for fallback
      ## Vivaldi browser with proprietary codecs and widevine support
      (vivaldi.override {
        proprietaryCodecs = true;
        enableWidevine = true;
        #vulkanSupport = true;
        commandLineArgs = "--enable-features=AcceleratedVideoDecodeLinuxGL,AcceleratedVideoEncoder,VaapiVideoDecoder,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,ignore-gpu-blocklist,enable-unsafe-webgpu,enable-zero-copy";
      })
    ];
  };
}
