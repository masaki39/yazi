-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Move Lines
map("n", "<C-S-Down>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<C-S-Up>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<C-S-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<C-S-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<C-S-Down>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<C-S-Up>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- quit
map({ "n", "i", "v" }, "<C-q>", "<esc><cmd>qa<cr>", { desc = "Quit All" })

-- Select All
map({ "n", "i", "v" }, "<C-a>", "<esc>ggVG", { desc = "Select All" })
