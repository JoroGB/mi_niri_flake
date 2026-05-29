{pkgs, ...}: {
  #cambiando ruta de almacenamiendo de postgresql
  # config.services.postgresql.dataDir = "/data/postgresql";

  # Configuracion De posgresql
  # activando Posgresql
  config.services.postgresql = {
    enable = true;
    settings = {
      listen_addresses = pkgs.lib.mkOverride 10 "*";
    };
    ensureDatabases = ["joronix-db" "joronix"];
    authentication = pkgs.lib.mkOverride 10 ''
      local   all  all                trust
      host    all  all  127.0.0.1/32  scram-sha-256
      host    all  all  172.17.0.0/16 scram-sha-256
    '';

    ensureUsers = [
      {
        name = "joronix";
        ensureDBOwnership = true;
        ensureClauses = {
          login = true;
          password = "SCRAM-SHA-256$4096:J/OJxZgZf0NsKOMlQI4dpQ==$YNBvQgfDFwNlv+BWPeds1P1mmZVRJ/4TavcXUj4zNT4=:GQERG3sFX/D4ZYPmc07lZLlWJQDybh1jJ8cz6WQgQKw=";
          # atributos del usuario
          bypassrls = true;
          createdb = true;
          createrole = true;
          "inherit" = true;
          superuser = true;
        };
      }
    ];
  };
}
