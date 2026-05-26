{
  pkgs,
  config,
  lib,
  ...
}: {
  #cambiando ruta de almacenamiendo de postgresql
  # config.services.postgresql.dataDir = "/data/postgresql";

  # Configuracion De posgresql
  # activando Posgresql
  config.services.postgresql = {
    enable = true;
    settings = {
      ssl = true;
    };
    ensureDatabases = ["joronix-db" "joronix"];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database  DBuser  auth-method
      local all       all     trust
      host joronix-db   all    127.0.0.1/32
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
  config = {
    # systemd.services.postgresql.postStart = lib.mkAfter ''
    #   $PSQL joronix-db -tAc 'GRANT ALL ON ALL TABLES IN SCHEMA public TO joronix' || true
    #   $PSQL joronix-db 'GRANT ALL ON ALL SEQUENCES IN SCHEMA public TO joronix' || true
    # '';
  };
}
