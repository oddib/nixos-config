{
  osConfig,
  lib,
  pkgs,
  ...
}: {
  config = lib.mkIf osConfig.system.desktop.enable {
    home.packages = with pkgs; [
      (vivaldi.override {
        proprietaryCodecs = true;
        enableWidevine = true;
        #vulkanSupport = true;
        commandLineArgs = ''
          --enable-features=AcceleratedVideoDecodeLinuxGL,AcceleratedVideoEncoder,VaapiVideoDecoder,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan --ignore-gpu-blocklist --enable-unsafe-webgpu --enable-zero-copy
        '';

        #commandLineArgs = "--enable-features=AcceleratedVideoDecodeLinuxGL,AcceleratedVideoEncoder,VaapiVideoDecoder,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE";

      })
    ];
  };
}
