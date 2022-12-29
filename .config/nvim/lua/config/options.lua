-- vim:foldmethod=marker

local o = vim.opt
local wo = vim.wo

o.secure = true
o.swapfile = false
o.clipboard = "unnamedplus"
o.history = 100

-- UI {{{
o.updatetime = 300
o.showmode = false
o.showtabline = 2
o.number = true
o.relativenumber = true
o.cursorline = true
o.scrolloff = 5
o.sidescrolloff = 5
o.splitbelow = true
o.splitright = true
o.termguicolors = true
o.wrap = false

o.fillchars = {
  vert = "┃",
  fold = " ",
  foldopen = "",
  foldsep = " ",
  foldclose = "",
}

-- UI:Fold
o.foldlevelstart = 4
o.foldcolumn = "1"
o.foldlevel = 99
o.foldenable = true
-- }}}

o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = true
o.shiftround = true
o.smartindent = true

o.wildmode = { "full", "list", "full" }
o.wildoptions = "pum"
o.pumblend = 10
o.pumheight = 10

o.completeopt = { "menuone", "noselect" }
