vim.g.mapleader = " "
vim.g.maplocalleader = "\\"
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set("i", "jj", "<esc>")
vim.keymap.set("i", "kk", "<esc>")
vim.keymap.set("i", "kj", "<esc>")
vim.keymap.set("n", "<leader>o", vim.cmd.Ex, { desc = "Open Netrw file explorer" })
vim.keymap.set("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })
vim.keymap.set("n", "<leader>wa", "<cmd>wa<cr>", { desc = "Save all files" })
vim.keymap.set("n", "<leader>wq", "<cmd>wq<cr>", { desc = "Save and quit" })
vim.keymap.set("n", "<leader>qq", "<cmd>q<cr>", { desc = "Quit" })
vim.keymap.set("n", "<leader>qa", "<cmd>qa<cr>", { desc = "Quit all" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selected lines down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selected lines up" })

vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor position" })
vim.keymap.set("n", "K", "mzK`z", { desc = "Join lines and keep cursor position" })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll down half-page and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll up half-page and center" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })

vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, { desc = "Format buffer with LSP" })

vim.keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste over without yanking" })

vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to system clipboard" })
vim.keymap.set("n", "<leader>Y", [["+Y]], { desc = "Yank line to system clipboard" })

vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete line to void register" })
vim.keymap.set({ "n", "v" }, "<leader>x", [["_x]], { desc = "Delete char to void register" })

vim.keymap.set({ "i", "n" }, "<C-c>", "<Esc>", { desc = "Escape" })
vim.keymap.set("n", "<leader>jk", "<Esc>", { desc = "Escape" })
