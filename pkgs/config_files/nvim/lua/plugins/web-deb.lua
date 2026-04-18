return {
  -- Treesitter para resaltado de sintaxis
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "html", "css", "scss", "javascript", "typescript" })
      end
    end,
  },

  -- LSP Configuration
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- HTML
        html = {
          filetypes = { "html", "htmldjango" },
        },
        -- CSS
        cssls = {
          settings = {
            css = {
              validate = true,
              lint = {
                unknownAtRules = "ignore",
              },
            },
            scss = {
              validate = true,
            },
            less = {
              validate = true,
            },
          },
        },
        -- Emmet para snippets HTML/CSS
        emmet_ls = {
          filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact" },
        },
      },
    },
  },

  -- Mason para instalar LSPs automáticamente
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, {
        "html-lsp",
        "css-lsp",
        "emmet-ls",
        "prettier", -- formateador
      })
    end,
  },

  -- Formateo con Prettier
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        javascript = { "prettier" },
        typescript = { "prettier" },
      },
    },
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {
      -- Solo activar en filetypes con tags HTML/XML
      enable_close = true,
      enable_rename = true,
      enable_close_on_slash = true,
    },
    ft = {
      "html",
      "xml",
      "jsx",
      "tsx",
      "javascript",
      "typescript",
      "javascriptreact",
      "typescriptreact",
      "svelte",
      "vue",
      "astro",
      "markdown",
      "php",
      "eruby",
    },
  },
}
