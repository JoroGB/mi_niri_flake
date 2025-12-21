-- ~/.config/nvim/lua/plugins/rust-dap.lua
return {
  -- Importar el extra de Rust de LazyVim
  { import = "lazyvim.plugins.extras.lang.rust" },

  -- Importar el extra de DAP
  { import = "lazyvim.plugins.extras.dap.core" },

  -- Configuración de Mason para instalar codelldb
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      ensure_installed = { "codelldb" },
      handlers = {
        -- Handler por defecto para otros adaptadores
        function(config)
          require("mason-nvim-dap").default_setup(config)
        end,

        -- Handler específico para codelldb/Rust
        codelldb = function(config)
          config.adapters = {
            type = "server",
            port = "${port}",
            executable = {
              command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
              args = { "--port", "${port}" },
            },
          }

          config.configurations = {
            {
              name = "Launch Rust Program",
              type = "codelldb",
              request = "launch",
              program = function()
                return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
              end,
              cwd = "${workspaceFolder}",
              stopOnEntry = false,
              args = {},
            },
            {
              name = "Debug Rust Tests",
              type = "codelldb",
              request = "launch",
              program = function()
                -- Esto permite debuggear tests específicos
                local test_name = vim.fn.input("Test name (leave empty for all): ")
                if test_name ~= "" then
                  vim.fn.system("cargo test --no-run " .. test_name)
                else
                  vim.fn.system("cargo test --no-run")
                end

                -- Encuentra el último ejecutable de test compilado
                local test_binary = vim.fn.system("ls -t target/debug/deps/*-* | grep -v '\\.d$' | head -n1")
                return vim.trim(test_binary)
              end,
              cwd = "${workspaceFolder}",
              stopOnEntry = false,
              args = {},
            },
          }

          require("mason-nvim-dap").default_setup(config)
        end,
      },
    },
  },

  -- Configuración adicional de nvim-dap para Rust
  {
    "mfussenegger/nvim-dap",
    opts = function()
      local dap = require("dap")

      -- Configuración adicional del adaptador si es necesario
      if not dap.adapters["codelldb"] then
        dap.adapters["codelldb"] = {
          type = "server",
          port = "${port}",
          executable = {
            command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
            args = { "--port", "${port}" },
          },
        }
      end

      -- Asegurar que las configuraciones de Rust estén disponibles
      if not dap.configurations.rust then
        dap.configurations.rust = {
          {
            name = "Launch",
            type = "codelldb",
            request = "launch",
            program = function()
              return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
            end,
            cwd = "${workspaceFolder}",
            stopOnEntry = false,
          },
        }
      end
    end,
  },

  -- Opcional: rustaceanvim para mejor integración con Rust
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = "rust",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = {
      dap = {
        adapter = {
          type = "server",
          port = "${port}",
          executable = {
            command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
            args = { "--port", "${port}" },
          },
        },
      },
    },
  },
}
