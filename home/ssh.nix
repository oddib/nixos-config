{...}: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      "*" = {
        identityAgent = "~/.1password/agent.sock";
      };
      "scuffedflix" = {
        user = "oddbjornmr";
        forwardAgent = true;
      };
    };
  };
}
