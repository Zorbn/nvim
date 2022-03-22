require("core")
require("packages")

---- Indentation
set_tab_width(4, true)

---- Lines
vim.o.number         = true
vim.o.relativenumber = true

---- Themeing
remove_excess_text()
vim.opt.termguicolors = true
vim.o.background      = "dark"
set_colorscheme("one-nvim")

-- Windows
vim.opt.splitright = true -- Prevents nvim-tree from opening files to the left

---- Keybinds
set_leader(" ")
map("n", "<leader>n", "<cmd>noh<cr>") -- For clearing search highlights
map("t", "<esc>",     "<C-\\><C-n>" ) -- For exiting terminal

---- LSP Setup
configure_lsp_windows({
    {"╭", "FloatBorder"},
    {"─", "FloatBorder"},
    {"╮", "FloatBorder"},
    {"│", "FloatBorder"},
    {"╯", "FloatBorder"},
    {"─", "FloatBorder"},
    {"╰", "FloatBorder"},
    {"│", "FloatBorder"},
})
configure_lsp_signs({ Error = " ", Warn = " ", Hint = " ", Info = " " })
