local opt = vim.opt
local wo = vim.wo

opt.path = vim.opt.path + '~,.,**'
opt.secure = true
opt.swapfile = false
opt.clipboard = 'unnamedplus'

opt.wildmode = {"full", "list", "full"}
opt.completeopt = {"menuone", "noselect"}

-- opt.foldmethod = "marker"
opt.foldmethod = 'expr'
opt.foldexpr = 'nvim_treesitter#foldexpr()'
opt.showmode = false
opt.splitbelow = true
opt.splitright = true
opt.updatetime = 100
opt.history = 100

opt.hidden = true
opt.lazyredraw = true
opt.synmaxcol = 600
opt.scrolloff = 5

opt.fillchars = { vert = "│", fold = "─"}
vim.o.switchbuf = 'useopen'
opt.termguicolors = true
opt.foldlevelstart = 1
wo.number = true
wo.cursorline = true
opt.showtabline=2


opt.ignorecase = true
opt.smartcase = true
opt.showmatch = true

opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.shiftround = true

vim.cmd('colorscheme base16-' .. vim.env.BASE16_THEME)

vim.g['vista#renderer#enable_icon'] = 1
vim.g.vista_disable_statusline = 1
vim.g.vista_default_executive = 'ctags'
vim.g.vista_default_executive = 'nvim_lsp'
vim.g.vista_echo_cursor_strategy = 'floating_win'



    -- autocmd BufEnter * call s:CheckLeftBuffers()
    -- autocmd BufWritePre * StripWhitespace

require('keymaps')
require('plugins')

vim.api.nvim_exec([[
augroup vimrc
    autocmd!
    autocmd BufRead,BufNewFile *.json setlocal conceallevel=0 foldmethod=syntax
    autocmd BufRead,BufNewFile *.md,*.mkd,*.markdown
            \ setlocal spell ft=markdown colorcolumn=80 conceallevel=0
    autocmd FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
    autocmd BufRead,BufNewFile *.yml,*.yaml setlocal colorcolumn=160
    autocmd BufWritePost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim
    autocmd FileType sh setlocal et ts=4 sw=4
    autocmd FileType qf setlocal nobuflisted
    autocmd FileType go setlocal noexpandtab shiftwidth=4 softtabstop=4 tabstop=4 nolist
    autocmd FileType python nnoremap <buffer><silent> <Leader>pe :AsyncRun! -mode=term -pos=bottom -rows=15 python "%"<CR>
    autocmd FileType python setlocal sw=4 sts=4 ts=4 et
    autocmd TermOpen term://* setlocal scrolloff=0 nonumber norelativenumber | startinsert
    autocmd ColorScheme * highlight Comment cterm=italic gui=italic
augroup END
]], true)
