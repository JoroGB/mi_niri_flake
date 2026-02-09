return {
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
}