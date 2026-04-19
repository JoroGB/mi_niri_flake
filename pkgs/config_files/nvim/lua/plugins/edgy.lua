return {
  {
    "folke/edgy.nvim",
    event = "VeryLazy",
    opts = {
      left = {

        {
          title = "Outline",
          ft = "Outline",
          pinned = true,
          open = "Outline",
          size = { height = 0.5 },
        },
      },
      bottom = {
        -- {
        --   title = "Neo-Tree",
        --   ft = "neo-tree",
        --   filter = function(buf)
        --     return vim.b[buf].neo_tree_source == "filesystem"
        --   end,
        --   pinned = true,
        --   open = "Neotree show position=left",
        --   size = { height = 0.5, widht = 40 },
        -- },
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
  },
  {
    "folke/edgy.nvim",
    opts = function(_, opts)
      local step = 15
      opts.keys = {
        -- increase width
        ["<c-Right>"] = function(win)
          win:resize("width", step)
        end,
        -- decrease width
        ["<c-Left>"] = function(win)
          win:resize("width", 0 - step)
        end,
        -- increase height
        ["<c-Up>"] = function(win)
          win:resize("height", 2)
        end,
        -- decrease height
        ["<c-Down>"] = function(win)
          win:resize("height", -2)
        end,
      }
    end,
  },
  {
    "folke/edgy.nvim",
    opts = function(_, opts)
      opts.left = vim.tbl_filter(function(item)
        return item.ft ~= "neo-tree"
      end, opts.left or {})

      opts.bottom = opts.bottom or {}

      table.insert(opts.bottom, {
        ft = "neo-tree",
        filter = function(buf)
          return vim.b[buf].neo_tree_source == "filesystem"
        end,
        size = { width = 0.3, height = 0.3 },
      })

      table.insert(opts.bottom, {
        ft = "snacks_terminal",
        size = { width = 0.7, height = 0.3 },
      })
    end,
  },
}
