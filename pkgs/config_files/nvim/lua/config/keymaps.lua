-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Remap <leader>q to start/stop macro recording in normal mode
-- vim.keymap.set("n", "<leader>q", "<Nop>", { remap = true, desc = "Record Macro" })
--
-- Unbind the default q key in normal mode
-- vim.keymap.set("n", "qr", "q", { desc = "Disable default q/macro record" })
vim.keymap.set("n", ",", "<Nop>", { noremap = true })
vim.keymap.set("n", "q", "<Nop>", { noremap = true })
vim.keymap.set("n", ",q", "q", { noremap = true, desc = "Record Macro" })
vim.keymap.set("n", ",d", "<cmd>DBUIToggle<cr>", { desc = "DBUIToggle" })

-- sets de comandos
vim.keymap.set("n", ",a", "vid", { noremap = true, desc = "Select inner block" })
local wk = require("which-key")
wk.add({
  { ",", group = "My Keymaps" },
  { ",q", desc = "Record Macro" },
  { ",d", desc = "DBUIToggle" },

  -- sets
  { ",a", desc = "Select inner block" },
})
