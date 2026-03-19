 # $env.config = {
 #          show_banner: false

 #          history: {
 #            max_size: 100_000
 #            sync_on_enter: false
 #            file_format: "sqlite"
 #            isolation: true  # Cada terminal tiene su propio historial
 #          }
 #        }

        $env.config = {
            show_banner: false
        }
          
        def backup_nvim_conf [] {
        nu ~/mi_niri_flake/backup_nvim.nu 
        }
        def ctmpfile_nvim [] {
           print "Limpiando archivos temporales de Neovim..."

           # Eliminar swap files
           print "Eliminando swap files..."
           rm -rf ~/.local/state/nvim/swap/*
           rm -rf ~/.local/share/nvim/swap/*

            # Eliminar shada files
           print "Eliminando shada files..."
           rm -rf ~/.local/state/nvim/shada/*
           rm -rf ~/.local/share/nvim/shada/*

            # Eliminar backups
           rm -rf ~/.local/share/nvim/backup/*
        }

        $env.config.history.sync_on_enter = false

        $env.config = ($env.config | upsert hooks {
            pre_prompt: [{
                code: "direnv export json | from json | default {} | load-env"
            }]
        })
