return {
  -- Deshabilitar snacks explorer
  {
    "folke/snacks.nvim",
    opts = {
      explorer = { enabled = false },
    },
    keys = {
      { "<leader>e", false },
      { "<leader>E", false },
    },
  },
  -- Neo-tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer Neo-Tree" },
      { "<leader>E", "<cmd>Neotree toggle dir=%:p:h<cr>", desc = "Explorer (cwd)" },
      { "<leader>be", "<cmd>Neotree buffers<cr>", desc = "Buffer Explorer" },
      { "<leader>ge", "<cmd>Neotree git_status<cr>", desc = "Git Explorer" },
    },
    opts = {
      window = {
        position = "left",
        width = 35,
      },
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_hidden = false,
        },
        follow_current_file = {
          enabled = true,
        },
      },
      buffers = {
        follow_current_file = {
          enabled = true,
        },
      },
      git_status = {
        window = {
          position = "float",
        },
      },
      default_component_configs = {
        git_status = {
          symbols = {
            -- Símbolos más visibles
            added = "✚",
            modified = "",
            deleted = "✖",
            renamed = "󰁕",
            untracked = "",
            ignored = "",
            unstaged = "󰄱",
            staged = "",
            conflict = "",
          },
        },
      },
    },
    config = function(_, opts)
      require("neo-tree").setup(opts)

      -- Personalizar colores para archivos modificados
      vim.api.nvim_set_hl(0, "NeoTreeGitModified", { fg = "#e0af68", bold = true }) -- Amarillo brillante
      vim.api.nvim_set_hl(0, "NeoTreeGitUntracked", { fg = "#7aa2f7", bold = true }) -- Azul brillante
      vim.api.nvim_set_hl(0, "NeoTreeGitAdded", { fg = "#9ece6a", bold = true }) -- Verde brillante
      vim.api.nvim_set_hl(0, "NeoTreeGitDeleted", { fg = "#f7768e", bold = true }) -- Rojo brillante
      vim.api.nvim_set_hl(0, "NeoTreeGitConflict", { fg = "#ff9e64", bold = true }) -- Naranja brillante
      vim.api.nvim_set_hl(0, "NeoTreeGitUnstaged", { fg = "#bb9af7", bold = true }) -- Púrpura brillante
    end,
  },
}
