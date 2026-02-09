return {
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     diagnostics = {
  --       underline = true,
  --       update_in_insert = false,
  --       virtual_text = {
  --         spacing = 4,
  --         source = "if_many",
  --         prefix = "●",
  --       },
  --       severity_sort = true,
  --     },
  --     servers = {
  --       rust_analyzer = {
  --         settings = {
  --           ["rust-analyzer"] = {
  --             check = {
  --               command = "clippy", -- Clippy da más warnings que check
  --               allFeatures = true,
  --             },
  --             diagnostics = {
  --               enable = true,
  --               disabled = {}, -- No deshabilitar ningún diagnóstico
  --               warningsAsHint = {}, -- Warnings como warnings, no hints
  --             },
  --             cargo = {
  --               allFeatures = true,
  --               loadOutDirsFromCheck = true,
  --             },
  --             procMacro = {
  --               enable = true,
  --             },
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
        "codelldb",
      },
    },
  }
}