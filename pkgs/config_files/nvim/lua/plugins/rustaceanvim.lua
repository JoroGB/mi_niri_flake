return {
  -- Configurar rustacean.nvim
  {
    "mrcjkb/rustaceanvim",
    version = "^7", -- use latest stable release
    lazy = false,
    ft = { "rust" },
    opts = {
      server = {
        on_attach = function(_, bufnr)
          -- Keybindings personalizados
          vim.keymap.set("n", "<leader>cR", function()
            vim.cmd.RustLsp("codeAction")
          end, { desc = "Code Action", buffer = bufnr })

          vim.keymap.set("n", "<leader>dr", function()
            vim.cmd.RustLsp("debuggables")
          end, { desc = "Rust Debuggables", buffer = bufnr })

          vim.keymap.set("n", "<leader>rr", function()
            vim.cmd.RustLsp("runnables")
          end, { desc = "Rust Runnables", buffer = bufnr })

          vim.keymap.set("n", "<leader>rt", function()
            vim.cmd.RustLsp("testables")
          end, { desc = "Rust Testables", buffer = bufnr })

          vim.keymap.set("n", "<leader>re", function()
            vim.cmd.RustLsp("expandMacro")
          end, { desc = "Expand Macro", buffer = bufnr })
        end,

        default_settings = {
          ["rust-analyzer"] = {
            -- diagnostics es para diagnosticos mas inmediatos,
            -- desactivar si hay problemas de rendimiento
            diagnostics = {
              enable = true,
              experimental = {
                enable = true, -- activa diagnósticos extra en memoria sin cargo
              },
            },
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            checkOnSave = {
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
            procMacro = {
              enable = true,
            },
            files = {
              excludeDirs = {
                ".direnv",
                ".git",
                ".github",
                ".gitlab",
                "bin",
                "node_modules",
                "target",
                "venv",
                ".venv",
              },
              -- Evitar problemas de "Roots Scanned hanging"
              watcher = "client",
            },
          },
        },
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})

      -- Verificar que rust-analyzer esté disponible
      if vim.fn.executable("rust-analyzer") == 0 then
        vim.notify(
          "**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
          vim.log.levels.ERROR,
          { title = "rustaceanvim" }
        )
      end
    end,
  },

  -- Deshabilitar rust_analyzer en lspconfig para evitar conflictos
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        rust_analyzer = {
          enabled = false, -- IMPORTANTE: deshabilitar para usar rustacean
        },
      },
    },
  },

  -- Soporte para Cargo.toml
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        crates = {
          enabled = true,
        },
      },
      lsp = {
        enabled = true,
        actions = true,
        completion = true,
        hover = true,
      },
    },
  },

  -- Integración con neotest (opcional)
  {
    "nvim-neotest/neotest",
    optional = true,
    opts = {
      adapters = {
        ["rustaceanvim.neotest"] = {},
      },
    },
  },
}

