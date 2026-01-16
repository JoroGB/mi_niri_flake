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

        $env.config.history.sync_on_enter = false

        $env.config = ($env.config | upsert hooks {
            pre_prompt: [{
                code: "direnv export json | from json | default {} | load-env"
            }]
        })
