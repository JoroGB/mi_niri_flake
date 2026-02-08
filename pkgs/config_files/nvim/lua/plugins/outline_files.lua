return {
  -- Deshabilitar snacks explorer completamente
  {
    "folke/snacks.nvim",
    opts = {
      explorer = { enabled = false },
    },
    keys = {
      -- Deshabilitar los keybindings de snacks explorer
      { "<leader>e", false },
      { "<leader>E", false },
    },
  },
  -- Habilitar neo-tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Explorer Neo-Tree" },
      { "<leader>E", "<cmd>Neotree toggle dir=%:p:h<cr>", desc = "Explorer (cwd)" },
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
    },
  },
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = {
      { "<leader>cs", "<cmd>Outline<CR>", desc = "Toggle Outline" },
    },
    opts = {
      outline_window = {
        position = "left",
        width = 25,
      },
      outline_items = {
        show_symbol_details = true,
      },
      symbols = {
        filter = {
          "Class",
          "Constructor",
          "Enum",
          "Function",
          "Interface",
          "Module",
          "Method",
          "Struct",
        },
      },
    },
  },
  {
    "folke/edgy.nvim",
    opts = {
      left = {
        {
          title = "Neo-Tree",
          ft = "neo-tree",
          filter = function(buf)
            return vim.b[buf].neo_tree_source == "filesystem"
          end,
          pinned = true,
          open = "Neotree show position=left",
          size = { height = 0.5 },
        },
        {
          title = "Outline",
          ft = "Outline",
          pinned = true,
          open = "Outline",
          size = { height = 0.5 },
        },
      },
    },
  },
}