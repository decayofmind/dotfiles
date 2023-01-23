vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.secure = true
vim.opt.swapfile = false
vim.opt.clipboard = "unnamedplus" -- TODO: "d" and "x" should NOT use system clipboard
vim.opt.history = 100

-- UI {{{
vim.opt.updatetime = 300
vim.opt.showmode = false
vim.opt.showtabline = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.termguicolors = true
vim.opt.wrap = false

vim.opt.fillchars = {
  vert = "┃",
  fold = " ",
  foldopen = "",
  foldsep = " ",
  foldclose = "",
}

-- UI:Fold
vim.opt.foldlevelstart = 4
vim.opt.foldcolumn = "1"
vim.opt.foldnestmax = 1
vim.opt.foldlevel = 99
-- vim:foldmethod=marker
vim.opt.foldenable = true
-- }}}

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.shiftround = true
vim.opt.smartindent = true

vim.opt.iskeyword:append { "-", "_" }

vim.opt.wildmode = { "full", "list", "full" }
vim.opt.wildoptions = "pum"
vim.opt.wildignorecase = true
vim.opt.pumblend = 10

vim.opt.pumheight = 10

vim.opt.completeopt = { "menuone", "noselect" }

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
