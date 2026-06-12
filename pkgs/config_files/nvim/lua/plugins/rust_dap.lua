-- ~/.config/nvim/lua/plugins/dap-rust.lua
return {
  -- nvim-dap base
  {
    "mfussenegger/nvim-dap",
    optional = true,
    dependencies = {
      -- UI opcional pero muy recomendado
      {
        "rcarriga/nvim-dap-ui",
        dependencies = { "nvim-neotest/nvim-nio" },
        opts = {},
        config = function(_, opts)
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup(opts)
          -- Abre/cierra la UI automáticamente al iniciar/terminar sesión
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
          end
        end,
      },
    },
    config = function()
      local dap = require("dap")

      -- ─── Adaptador codelldb ───────────────────────────────────────────────
      -- Ajusta la ruta según donde nix instaló codelldb
      local codelldb_path = vim.fn.expand("~/.nix-profile/share/vscode/extensions/vadimcn.vscode-lldb/adapter/codelldb")

      -- Fallback: buscar en PATH si rustaceanvim ya lo gestionó
      if vim.fn.filereadable(codelldb_path) == 0 then
        codelldb_path = vim.fn.exepath("codelldb")
      end

      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = codelldb_path,
          args = { "--port", "${port}" },
        },
      }

      -- Alias para que rustaceanvim también lo encuentre como "lldb"
      dap.adapters.lldb = dap.adapters.codelldb

      -- ─── Configuraciones de lanzamiento para Rust ────────────────────────
      dap.configurations.rust = {
        {
          name = "Debug binary (cargo build)",
          type = "codelldb",
          request = "launch",
          -- Compila en modo debug y lanza el binario resultante
          program = function()
            -- Obtiene el nombre del proyecto desde Cargo.toml
            local cargo_toml = vim.fn.findfile("Cargo.toml", vim.fn.getcwd() .. ";")
            local bin_name = vim.fn.fnamemodify(vim.fn.fnamemodify(cargo_toml, ":h"), ":t")
            local target = vim.fn.getcwd() .. "/target/debug/" .. bin_name
            -- Compila antes de depurar
            vim.fn.system("cargo build 2>&1")
            if vim.v.shell_error ~= 0 then
              vim.notify("cargo build falló", vim.log.levels.ERROR)
              return dap.ABORT
            end
            return target
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
        {
          name = "Debug binary (seleccionar manualmente)",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Ruta al binario: ", vim.fn.getcwd() .. "/target/debug/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
        {
          name = "Debug test (función actual)",
          type = "codelldb",
          request = "launch",
          -- Compila y lanza el binario de test
          program = function()
            vim.fn.system("cargo test --no-run 2>&1")
            if vim.v.shell_error ~= 0 then
              vim.notify("cargo test --no-run falló", vim.log.levels.ERROR)
              return dap.ABORT
            end
            -- Encuentra el binario de test más reciente
            local result = vim.fn.system(
              "find target/debug/deps -maxdepth 1 -executable -newer target/debug/.cargo-lock "
                .. "-not -name '*.d' 2>/dev/null | head -1"
            )
            return vim.trim(result)
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          args = {},
        },
        {
          name = "Attach to process",
          type = "codelldb",
          request = "attach",
          pid = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
    end,
  },

  -- ─── Keymaps ─────────────────────────────────────────────────────────────
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Condición: "))
        end,
        desc = "Breakpoint con condición",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue / Start",
      },
      {
        "<leader>dn",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>do",
        function()
          require("dap").step_out()
        end,
        desc = "Step Out",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.open()
        end,
        desc = "Abrir REPL",
      },
      {
        "<leader>dl",
        function()
          require("dap").run_last()
        end,
        desc = "Repetir última sesión",
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle DAP UI",
      },
      {
        "<leader>dx",
        function()
          require("dap").terminate()
        end,
        desc = "Terminar sesión",
      },
    },
  },
}
