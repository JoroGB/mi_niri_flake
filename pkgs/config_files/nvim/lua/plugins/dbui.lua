return {
  {
    "kristijanhusak/vim-dadbod-ui",
    keys = {
      -- 1. Disable the default LazyVim keybind
      { "<leader>D", false },
      -- 2. Define your new custom keybind (e.g., <leader>du)
      { "<leader>du", "<cmd>DBUIToggle<cr>", desc = "Toggle Dadbod UI" },
    },
  },
}
