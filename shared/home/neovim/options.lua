-- disable netrw because of nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set("n", "<Space>", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.pumheight = 10
vim.o.clipboard = "unnamedplus"

vim.o.number = true
-- vim.o.relativenumber = true

vim.o.signcolumn = "yes"

vim.o.tabstop = 4
vim.o.shiftwidth = 4

vim.o.updatetime = 300

vim.o.termguicolors = true

vim.o.mouse = ""
