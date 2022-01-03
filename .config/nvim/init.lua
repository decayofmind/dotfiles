local opt = vim.opt
local wo = vim.wo

opt.path = vim.opt.path + "~,.,**"
opt.secure = true
opt.swapfile = false
opt.clipboard = "unnamedplus"

opt.wildmode = { "full", "list", "full" }
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

require("keymaps")
require("impatient").enable_profile()
require("packer_compiled")
require("plugins")
require("config")

vim.api.nvim_exec(
	[[
augroup vimrc
    autocmd!
    autocmd ColorScheme * highlight Comment cterm=italic gui=italic
    autocmd BufRead,BufNewFile *.md,*.mkd,*.markdown
            \ setlocal spell ft=markdown colorcolumn=80 conceallevel=0
    autocmd FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
    autocmd BufRead,BufNewFile *.yml,*.yaml setlocal colorcolumn=160
    autocmd BufWritePost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim
    autocmd BufNewFile,BufRead */tasks/*.yml setfiletype yaml.ansible
    autocmd BufNewFile,BufRead */handlers/*.yml setfiletype yaml.ansible
    autocmd BufNewFile,BufRead */default/*.yml setfiletype yaml.ansible
    autocmd BufNewFile,BufRead */templates/*.tpl setlocal modelines=0
    " https://github.com/towolf/vim-helm
    autocmd BufRead,BufNewFile */templates/*.yaml,*/templates/*.tpl,*.gotmpl,helmfile.yaml set ft=helm
    autocmd FileType helm setlocal commentstring={{/*\ %s\ */}}

    autocmd FileType gitcommit setlocal spell spelllang=en_us
    autocmd FileType sh setlocal et ts=4 sw=4
    autocmd FileType qf setlocal nobuflisted
    autocmd FileType go setlocal noexpandtab shiftwidth=8 softtabstop=8 tabstop=8 nolist
    autocmd FileType tf setlocal filetype=terraform
    autocmd FileType python nnoremap <buffer><silent> <Leader>pe :AsyncRun! -mode=term -pos=bottom -rows=15 python "%"<CR>
    autocmd FileType python setlocal sw=4 sts=4 ts=4 et
augroup END
]],
	true
)

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
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
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
