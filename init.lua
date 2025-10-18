---@diagnostic disable: undefined-global

vim.cmd("set expandtab")
vim.cmd("set tabstop=4")
vim.cmd("set softtabstop=4")
vim.cmd("set shiftwidth=4")
vim.g.mapleader = " "

require("config.lazy")

vim.opt.clipboard = "unnamedplus"
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy selection to system clipboard" })
vim.keymap.set("n", "<C-v>", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("i", "<C-v>", "<C-r>+", { desc = "Paste from system clipboard" })

vim.keymap.set("n", "<leader>th", function()
	vim.cmd("split | terminal")
	vim.cmd("startinsert")
end, { desc = "Open terminal in horizontal split" })

vim.keymap.set("n", "<leader>tv", function()
	vim.cmd("vsplit | terminal")
	vim.cmd("startinsert")
end, { desc = "Open terminal in vertical split" })

vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })


