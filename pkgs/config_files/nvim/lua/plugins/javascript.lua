return {
  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- TypeScript/JavaScript LSP
        ts_ls = {
          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
            javascript = {
              inlayHints = {
                includeInlayParameterNameHints = "all",
                includeInlayParameterNameHintsWhenArgumentMatchesName = true,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },
            },
          },
        },
        -- ESLint (opcional pero recomendado)
        eslint = {
          settings = {
            workingDirectories = { mode = "auto" },
          },
        },
      },
    },
  },

  -- DAP Configuration
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "js-debug-adapter" })
        end,
      },
    },
    opts = function()
      local dap = require("dap")

      -- Configuración para Node.js
      -- dap.adapters["pwa-node"] = {
      --   type = "server",
      --   host = "localhost",
      --   port = "${port}",
      --   executable = {
      --     command = "node",
      --     args = {
      --       require("mason-registry").get_package("js-debug-adapter"):get_install_path()
      --         .. "/js-debug/src/dapDebugServer.js",
      --       "${port}",
      --     },
      --   },
      -- }
      --
      -- -- -- Configuración para Chrome/Edge
      -- dap.adapters["pwa-chrome"] = {
      --   type = "server",
      --   host = "localhost",
      --   port = "${port}",
      --   executable = {
      --     command = "node",
      --     args = {
      --       require("mason-registry").get_package("js-debug-adapter"):get_install_path()
      --         .. "/js-debug/src/dapDebugServer.js",
      --       "${port}",
      --     },
      --   },
      -- }
      --
      -- Configuraciones de debug
      for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
        dap.configurations[language] = {
          -- Debug Node.js
          {
            type = "pwa-node",
            request = "launch",
            name = "Launch file",
            program = "${file}",
            cwd = "${workspaceFolder}",
          },
          {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = "${workspaceFolder}",
          },
          -- Debug aplicaciones web
          {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch Chrome",
            url = "http://localhost:3000",
            webRoot = "${workspaceFolder}",
          },
          -- Debug Jest tests
          {
            type = "pwa-node",
            request = "launch",
            name = "Debug Jest Tests",
            runtimeExecutable = "node",
            runtimeArgs = {
              "./node_modules/jest/bin/jest.js",
              "--runInBand",
            },
            rootPath = "${workspaceFolder}",
            cwd = "${workspaceFolder}",
            console = "integratedTerminal",
            internalConsoleOptions = "neverOpen",
          },
        }
      end
    end,
  },
}
