{pkgs, ...}: {
  config.services.mongodb = {
    enable = true;
    package = pkgs.mongodb-ce;
  };

  config.environment.systemPackages = with pkgs; [
    mongosh
  ];

  config.environment.sessionVariables = {
    GLIBC_TUNABLES = "glibc.pthread.rseq=0";
  };
}
