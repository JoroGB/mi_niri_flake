return {
  "folke/edgy.nvim",
  event = "VeryLazy",
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
    bottom = {
      {
        title = "Neo-Tree Git",
        ft = "neo-tree",
        filter = function(buf)
          return vim.b[buf].neo_tree_source == "git_status"
        end,
        open = "Neotree git_status",
        size = { height = 0.3 },
      },
      {
        title = "Neo-Tree Buffers",
        ft = "neo-tree",
        filter = function(buf)
          return vim.b[buf].neo_tree_source == "buffers"
        end,
        open = "Neotree buffers",
        size = { height = 0.3 },
      },
    },
  },
}

