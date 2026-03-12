{...}: {
  #cambiando ruta de almacenamiendo de postgresql
  # config.services.postgresql.dataDir = "/data/postgresql";

  # Configuracion De posgresql
  # activando Posgresql
  config.services.postgresql = {
    enable = true;
    ensureDatabases = ["joronix"];
    # authentication = pkgs.lib.mkOverride 10 ''
    #   #type database  DBuser  auth-method
    #   local all       all     trust
    # '';

    identMap = ''
      # ArbitraryMapName systemUser DBUser
         superuser_map      root      postgres
         superuser_map      postgres  postgres
         # Let other names login as themselves
         superuser_map      /^(.*)$   \1
    '';
    ensureUsers = [
      {
        name = "joronix";
        ensureDBOwnership = true;
        ensureClauses = {
          login = true;
          password = "SCRAM-SHA-256$4096:J/OJxZgZf0NsKOMlQI4dpQ==$YNBvQgfDFwNlv+BWPeds1P1mmZVRJ/4TavcXUj4zNT4=:GQERG3sFX/D4ZYPmc07lZLlWJQDybh1jJ8cz6WQgQKw=";
        };
      }
    ];
  };
}
