{ pkgs, ... }:

{
  home.packages = with pkgs;
    [
      (vivaldi.override {
        proprietaryCodecs = true;
        enableWidevine = true;
        #vulkanSupport = true; 
        commandLineArgs = "--enable-features=AcceleratedVideoDecodeLinuxGL,VaapiVideoDecoder,VaapiIgnoreDriverChecks,Vulkan,DefaultANGLEVulkan,VulkanFromANGLE";
      })
    ];
}
