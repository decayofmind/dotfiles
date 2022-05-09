local opt = vim.opt
local wo = vim.wo
local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

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
opt.showmode = false
opt.splitbelow = true
opt.splitright = true
opt.updatetime = 100
opt.history = 100

opt.hidden = true
opt.lazyredraw = true
opt.synmaxcol = 600
opt.scrolloff = 5

vim.o.smartindent = true
opt.fillchars = { vert = "│", fold = "─" }
vim.o.switchbuf = "useopen"
opt.termguicolors = true
opt.foldlevelstart = 1
wo.number = true
wo.cursorline = true
opt.showtabline = 2

opt.ignorecase = true
opt.smartcase = true
opt.showmatch = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.shiftround = true

vim.g["vista#renderer#enable_icon"] = 1
vim.g.vista_disable_statusline = 1
vim.g.vista_default_executive = "nvim_lsp"
vim.g.vista_echo_cursor_strategy = "floating_win"

_G.__luacache_config = {
  chunks = {
    enable = true,
    path = vim.fn.stdpath('cache')..'/luacache_chunks',
  },
  modpaths = {
    enable = true,
    path = vim.fn.stdpath('cache')..'/luacache_modpaths',
  }
}
require("impatient").enable_profile()
require("packer_compiled")
require("plugins")
require("keymaps")

augroup("VimInit", { clear = true })
autocmd(
  "BufWritePost",
  { pattern = "~/.config/nvim/init.lua", command = "source ~/.config/nvim/init.lua", group = "VimInit" }
)

augroup("Format", { clear = true })
autocmd("ColorScheme", { pattern = "*", command = "highlight Comment cterm=italic gui=italic", group = "Format" })
autocmd("FileType", { pattern = "gitcommit", command = "setlocal spell spelllang=en_us", group = "Format" })
autocmd("FileType", { pattern = "helm", command = "setlocal commentstring={{/*\\ %s\\ */}}", group = "Format" })
autocmd("FileType", { pattern = "python", command = "setlocal sw=4 sts=4 ts=4 et", group = "Format" })
autocmd("FileType", { pattern = "sh", command = " setlocal et ts=4 sw=4", group = "Format" })
autocmd("FileType", { pattern = "qf", command = "setlocal nobuflisted", group = "Format" })
autocmd(
  "FileType",
  { pattern = "markdown", command = "vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>", group = "Format" }
)
autocmd(
  "FileType",
  { pattern = "go", command = "setlocal noexpandtab shiftwidth=8 softtabstop=8 tabstop=8 nolist", group = "Format" }
)

autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.md", "*.mkd", "*.markdown" },
  command = "setlocal spell colorcolumn=120 conceallevel=0",
  group = "Format",
})
autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = "*/templates/*.tpl", command = "setlocal modelines=0", group = "Format" }
)
autocmd(
  { "BufRead", "BufNewFile" },
  { pattern = { "*.yml", "*.yaml" }, command = "setlocal colorcolumn=160", group = "Format" }
)

local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

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
  -- "netrw",
  -- "netrwPlugin",
  -- "netrwSettings",
  -- "netrwFileHandlers",
  "gzip",
  "zip",
  "zipPlugin",
  "tar",
  "tarPlugin",
  "getscript",
  "getscriptPlugin",
  "vimball",
  "vimballPlugin",
  "2html_plugin",
  "logipat",
  "rrhelper",
  "spellfile_plugin",
  "matchit",
}

for _, plugin in pairs(disabled_built_ins) do
  vim.g["loaded_" .. plugin] = 1
end
