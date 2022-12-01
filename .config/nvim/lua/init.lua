_G.__luacache_config = {
  chunks = {
    enable = true,
    path = vim.fn.stdpath("cache") .. "/luacache_chunks",
  },
  modpaths = {
    enable = false,
    path = vim.fn.stdpath("cache") .. "/luacache_modpaths",
  },
}

local impatient_ok, impatient = pcall(require, "impatient")
if impatient_ok then
  impatient.enable_profile()
end

local opt = vim.opt
local wo = vim.wo

opt.path = vim.opt.path + "~,.,**"

opt.secure = true

opt.swapfile = false
opt.clipboard = "unnamedplus"

opt.wildmode = { "full", "list", "full" }
opt.wildoptions = "pum"
opt.pumblend = 7
opt.pumheight = 20

opt.completeopt = { "menuone", "noselect" }

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevelstart = 1
wo.foldcolumn = "1"
wo.foldlevel = 99
wo.foldenable = true
opt.showmode = false
opt.splitbelow = true
opt.splitright = true
opt.updatetime = 100
opt.history = 100

opt.lazyredraw = true
opt.synmaxcol = 600
opt.scrolloff = 5

vim.o.smartindent = true
opt.fillchars = { vert = "│", fold = "─" }
vim.o.switchbuf = "useopen"
opt.termguicolors = true
wo.number = true
wo.relativenumber = true
wo.cursorline = true

opt.showtabline = 2

opt.iskeyword = opt.iskeyword + "-"
opt.ignorecase = true
opt.smartcase = true
opt.showmatch = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.shiftround = true

require("plugins")
require("keymaps")

vim.api.nvim_exec(
  [[
      cnoreabbrev W! w!
      cnoreabbrev Q! q!
      cnoreabbrev Qall! qall!
      cnoreabbrev Wq wq
      cnoreabbrev Wa wa
      cnoreabbrev wQ wq
      cnoreabbrev WQ wq
      cnoreabbrev W w
      cnoreabbrev Q q
      cnoreabbrev Qall qall
    ]],
  false
)

local disabled_built_ins = {
  "2html_plugin",
  "getscript",
  "getscriptPlugin",
  "gzip",
  "logipat",
  -- "netrw",
  -- "netrwPlugin",
  -- "netrwSettings",
  -- "netrwFileHandlers",
  "matchit",
  "matchparen",
  "tar",
  "tarPlugin",
  "rrhelper",
  "vimball",
  "vimballPlugin",
  "zip",
  "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
