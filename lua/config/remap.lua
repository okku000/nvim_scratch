vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set("i","jk","<esc>")
vim.keymap.set("n", "<leader>o", vim.cmd.Ex, { desc = "Open Netrw file explorer" })
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>wa", "<cmd>wa<cr>", { desc = "Save all files" })
vim.keymap.set("n", "<leader>wq", "<cmd>wq<cr>", { desc = "Save and quit" })
vim.keymap.set("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>qa", "<cmd>qa<cr>", { desc = "Quit all" })

-- Move selected lines down in visual mode
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })

-- Move selected lines up in visual mode
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

-- Join lines without moving cursor
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })

-- Scroll down half a page and center cursor
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down half-page and center" })

-- Scroll up half a page and center cursor
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half-page and center" })

-- Search forward and center result
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" })

-- Search backward and center result
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Format buffer using LSP
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "Format buffer with LSP" })

-- Paste over selection without yanking
vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste over without yanking" })

-- Yank to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

-- Delete to void register
vim.keymap.set({"n", "v"}, "<leader>d", [["_d]], { desc = "Delete to void register" })
vim.keymap.set({"n", "v"}, "<leader>x", [["_x]], { desc = "Delete to void register" })

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")
vim.keymap.set("n", "<leader>jk", "<Esc>")
