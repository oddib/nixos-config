{ stdenv, linux, fetchFromGitHub, lib }:

stdenv.mkDerivation rec {
  pname = "samsung-galaxybook-module";
  version = "unstable-2025-01-29";

  src = fetchFromGitHub {
    owner = "joshuagrisham";
    repo = "samsung-galaxybook-extras";
    rev = "main"; # or specific commit hash
    hash = "sha256-srCGcmUI5ZKjndIWhSptG3hVkAo0dvDjJ4NoUkutaIA=";
  };

  nativeBuildInputs = [ linux.dev ];
  buildInputs = [ linux ];

  KERNEL_VERSION = linux.modDirVersion;
  KERNEL_SRC = "${linux.dev}/lib/modules/${KERNEL_VERSION}/build";
  INSTALL_MOD_PATH = placeholder "out";

  buildPhase = ''
    runHook preBuild
    make -C $KERNEL_SRC M=$PWD modules
    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall
    make -C $KERNEL_SRC M=$PWD modules_install
    runHook postInstall
  '';

  meta = with lib; {
    description = "Kernel module for Samsung Galaxybook devices";
    homepage = "https://github.com/joshuagrisham/samsung-galaxybook-extras";
    platforms = platforms.linux;
    # Important for kernel module compatibility
    broken = !versionAtLeast linux.version "6.5";
  };
}
