set encoding=utf-8 nobomb
scriptencoding utf-8
set fileencoding=utf-8
set termencoding=utf-8

" General {{{

let g:mapleader = "\<SPACE>"

" set nocompatible
filetype plugin indent on
syntax enable
set shell=$SHELL

set autoread
set backupdir=/tmp//
set clipboard+=unnamed,unnamedplus
set diffopt+=internal,algorithm:patience
set directory=/tmp//
set formatoptions-=o
set modelines=2
set mouse=a
set pastetoggle=<F2>
set path+=**
set secure
set ttimeout
set ttimeoutlen=100
set ttyfast
set undolevels=1000
" }}}

" Completion {{{
set wildmenu
set wildmode=longest:full,full  " show vertical menu
set complete-=i
set completeopt+=noselect
" }}}

" UX {{{
set backspace=indent,eol,start
set cursorline
set noerrorbells
set foldlevelstart=0
set foldmethod=marker
set fillchars=vert:│
set fillchars+=fold:─
set hidden
set nrformats-=octal
set number
set ruler
set scrolloff=5
set shortmess=aIoO
set showcmd
set showmatch
set noshowmode
set showtabline=2
set sidescrolloff=2
set splitbelow
set splitright
set switchbuf=useopen
set synmaxcol=500
set updatetime=100
set visualbell t_vb=
" }}}

" Searching {{{
set hlsearch
set incsearch
set ignorecase
set showmatch
set smartcase
set gdefault

if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow\ --multiline-dotall
endif
" }}}

" Whitespaces {{{
set autoindent
set softtabstop=2
set tabstop=2
set shiftwidth=2
set shiftround
set smarttab
set expandtab
set list
set listchars=tab:╶─
set listchars+=trail:·
set listchars+=extends:#
set listchars+=nbsp:%
" }}}

" Plug {{{
"
let s:plug_vim_path = '~/.local/share/nvim/site/autoload/plug.vim'
let s:plugged_path = '~/.local/share/nvim/plugged'

if empty(glob(s:plug_vim_path))
  execute 'silent !curl -fLo  ' . s:plug_vim_path . ' --create-dirs ' .
          \ 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  " vint: next-line -ProhibitAutocmdWithNoGroup
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(s:plugged_path)
  Plug 'tpope/vim-sleuth'
  Plug 'tpope/vim-dispatch'
  Plug 'AdUki/vim-dispatch-neovim'
  Plug 'jszakmeister/vim-togglecursor'
  Plug 'svermeulen/vim-yoink'
  Plug 'airblade/vim-rooter'
  Plug 'direnv/direnv.vim'

  Plug 'junegunn/vim-peekaboo'  " browse registers

  Plug 'itchyny/lightline.vim'
  Plug 'mike-hearn/base16-vim-lightline'
  Plug 'mengelbrecht/lightline-bufferline'
  Plug 'maximbaz/lightline-ale'
  Plug 'decayofmind/vim-lightline-functions'

  Plug 'luochen1990/rainbow'

  Plug 'itspriddle/vim-marked'
  Plug 'darfink/vim-plist'
  Plug 'Valloric/ListToggle'
  Plug 'skywind3000/asyncrun.vim'
  Plug 'mcchrish/nnn.vim'
  Plug 'scrooloose/nerdtree'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }

  " Edit
  Plug 'tpope/vim-repeat'
  Plug 'tpope/vim-surround'
  Plug 'tpope/vim-endwise'
  " Plug 'jiangmiao/auto-pairs'
  Plug 'scrooloose/nerdcommenter'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
  Plug 'Yggdroot/indentLine'
  Plug 'editorconfig/editorconfig-vim'
  Plug 'chrisbra/vim-diff-enhanced'
  Plug 'junegunn/vim-easy-align'
  " Plug 'SirVer/ultisnips', { 'tag': '3.2' }  " Latest version with Py2 support
  Plug 'Shougo/neosnippet.vim'
  Plug 'Shougo/neosnippet-snippets'
  Plug 'honza/vim-snippets'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'junegunn/goyo.vim'
  Plug 'mhinz/vim-grepper'
  Plug 'ap/vim-css-color'

  " Fuzzy-finder
  if isdirectory('/usr/local/opt/fzf')  " MacOS related
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
  else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
  endif
  Plug 'yuki-ycino/fzf-preview.vim', { 'branch': 'release', 'do': ':UpdateRemotePlugins' } | Plug 'Shougo/neomru.vim'

  " Git {{{
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'mattn/gist-vim' | Plug 'mattn/webapi-vim'
  " }}}

  " Languages {{{
  Plug 'rizzatti/dash.vim'
  Plug 'liuchengxu/vista.vim'  " tagbar replacement
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'sheerun/vim-polyglot'  " multilanguage
  Plug 'fatih/vim-go'
  Plug 'pedrohdz/vim-yaml-folds'

  Plug 'dense-analysis/ale'  " linting (requires async)
  Plug 'neoclide/coc.nvim', {'branch': 'release'}  " completion
  " }}}

  " Color scheme
  Plug 'chriskempson/base16-vim'

  " Misc
  Plug 'ryanoasis/vim-devicons'
  Plug 'vwxyutarooo/nerdtree-devicons-syntax'

call plug#end()
" }}}

" Terminal colors {{{
if $TERM =~? '-256color'
  set t_Co=256
endif
set t_md=

" Enable 24bit colors in terminal
if has('termguicolors')
  set termguicolors
endif

" set colorscheme
if isdirectory(expand(s:plugged_path . '/base16-vim'))
  if exists('$BASE16_THEME') && (!exists('g:colors_name') || g:colors_name != 'base16-' . $BASE16_THEME)
    let base16colorspace=256
    execute 'colorscheme base16-' . $BASE16_THEME
  endif
endif

highlight Comment gui=italic cterm=italic

" }}}

" Plugin settings {{{

" junegunn/fzf.vim {{{
let g:fzf_layout = { 'down': '~20%'  }
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

let $FZF_DEFAULT_OPTS='--layout=reverse'
let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, 'number', 'no')

  let height = float2nr(&lines/2)
  let width = float2nr(&columns - (&columns * 4 / 10))
  let row = float2nr(&lines / 4)
  let col = float2nr((&columns - width) / 2)

  let opts = {
        \ 'relative': 'editor',
        \ 'row': row,
        \ 'col': col,
        \ 'width': width,
        \ 'height':height,
        \ }
  let win =  nvim_open_win(buf, v:true, opts)
  call setwinvar(win, '&number', 0)
  call setwinvar(win, '&relativenumber', 0)
endfunction

" nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
" nnoremap <silent> <Leader><Enter>  :Buffers<CR>
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})
" }}}

" yuki-ycino/fzf-preview.vim {{{
let g:fzf_preview_command = 'bat --color=always --theme base16 --style=grid {-1}'
let g:fzf_preview_use_dev_icons = 1

nmap <Leader>f [fzf-p]
xmap <Leader>f [fzf-p]
nnoremap <silent> <Leader><Leader> :<C-u>FzfPreviewFromResources project_mru git<CR>
nnoremap <silent> [fzf-p]p :<C-u>FzfPreviewFromResources project_mru git<CR>
nnoremap <silent> [fzf-p]gs :<C-u>FzfPreviewGitStatus<CR>
nnoremap <silent> <Leader><Enter> :<C-u>FzfPreviewBuffers<CR>
nnoremap <silent> [fzf-p]b :<C-u>FzfPreviewBuffers<CR>
nnoremap <silent> [fzf-p]B :<C-u>FzfPreviewAllBuffers<CR>
nnoremap <silent> [fzf-p]o :<C-u>FzfPreviewFromResources buffer project_mru<CR>
nnoremap <silent> [fzf-p]<C-o> :<C-u>FzfPreviewJumps<CR>
nnoremap <silent> [fzf-p]g; :<C-u>FzfPreviewChanges<CR>
nnoremap <silent> [fzf-p]/ :<C-u>FzfPreviewLines -add-fzf-arg=--no-sort -add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-p]* :<C-u>FzfPreviewLines -add-fzf-arg=--no-sort -add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap          [fzf-p]gr :<C-u>FzfPreviewProjectGrep<Space>
xnoremap          [fzf-p]gr "sy:FzfPreviewProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> [fzf-p]t :<C-u>FzfPreviewBufferTags<CR>
nnoremap <silent> [fzf-p]q :<C-u>FzfPreviewQuickFix<CR>
nnoremap <silent> [fzf-p]l :<C-u>FzfPreviewLocationList<CR>
" }}}

" itchyny/lightline.vim {{{

let g:lightline = {}
if exists('$BASE16_THEME')
  let g:lightline.colorscheme = tr(g:colors_name, '-', '_')
endif
let g:lightline.active = {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'filename'],
    \             [ 'gitinfo', 'method', 'cocstatus']
    \           ],
    \   'right': [
    \       [],
    \       ['filetype', 'fileencoding', 'fileformat', 'lineinfo'],
    \       [ 'linter_checking', 'linter_errors', 'linter_warnings', 'linter_ok' ],
    \       ['gitblame'],
    \   ]
    \ }
let g:lightline.tabline = {'left': [['buffers']], 'right': []}
let g:lightline.tab = {
      \ 'active': [ 'tabnum', 'filename', 'filetype', 'modified' ]
      \ }
let g:lightline.component_expand = {}
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_warnings = "\uf071 "
let g:lightline#ale#indicator_errors = "\uf05e "
let g:lightline#ale#indicator_ok = "\uf00c"
let g:lightline.component_expand = {
      \   'buffers': 'lightline#bufferline#buffers',
      \   'linter_checking': 'lightline#ale#checking',
      \   'linter_warnings': 'lightline#ale#warnings',
      \   'linter_errors': 'lightline#ale#errors',
      \   'linter_ok': 'lightline#ale#ok',
      \ }
let g:lightline.component_type = {
      \   'buffers': 'tabsel',
      \   'linter_checking': 'left',
      \   'linter_warnings': 'warning',
      \   'linter_errors': 'error',
      \   'linter_ok': 'left',
      \ }
let g:lightline.component_function = {
    \   'cocstatus': 'coc#status',
    \   'fileencoding': 'lightline#functions#fileencoding',
    \   'fileformat': 'lightline#functions#fileformat_devicons',
    \   'filename': 'lightline#functions#filename',
    \   'filetype': 'lightline#functions#filetype_devicons',
    \   'gitinfo': 'lightline#functions#gitinfo_coc',
    \   'gitblame': 'lightline#functions#gitblame_coc',
    \   'lineinfo': 'lightline#functions#lineinfo',
    \   'method': 'lightline#functions#method_vista',
    \   'mode': 'lightline#functions#mode',
    \   'readonly': 'lightline#functions#readonly',
  \ }
let g:lightline.mode_map = {
      \ 'n': 'N', 'i': 'I', 'R': 'R', 'v': 'V', 'V': 'V', "\<C-v>": 'V',
      \ 'c': 'C', 's': 'S', 'S': 'S', "\<C-s>": 'S', 't': 'T',
      \ }
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }
let g:lightline#bufferline#enable_devicons = 1
" }}}


let g:AutoPairsMapCh = 0

let g:rainbow_active = 0

let g:neosnippet#snippets_directory = s:plugged_path . 'neosnippet-snippets/neosnippets'
let g:neosnippet#snippets_directory = s:plugged_path . 'vim-snippets/snippets'

let g:coc_global_extensions = [
    \ 'coc-git',
    \ 'coc-fzf-preview',
    \ 'coc-json',
    \ 'coc-lists',
    \ 'coc-pairs',
    \ 'coc-python',
    \ 'coc-neosnippet',
    \ 'coc-yaml',
    \ 'coc-yank',
\ ]
let g:coc_filetype_map = {
    \ 'yaml.ansible': 'yaml'
\ }

nmap <leader>rn <Plug>(coc-rename)
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gc <Plug>(coc-git-commit)
nmap <leader>gdc :CocCommand git.diffCached<CR>
nnoremap <leader>gfu :CocCommand git.foldUnchanged<CR>
nnoremap <leader>gcs :CocCommand git.chunkStage<CR>
nnoremap <leader>gcu :CocCommand git.chunkUndo<CR>
nnoremap <leader>gci :CocCommand git.chunkInfo<CR>
nnoremap <silent><leader>K :call CocAction("doHover")<CR>

nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>
let g:ale_sign_error = '✖'
let g:ale_sign_warning = '⚠'
let g:ale_linters = {'gitcommit': ['languagetool']}

let g:vim_json_syntax_conceal = 0

let g:gutentags_cache_dir = '~/.cache/ctags'
let g:gutentags_define_advanced_commands = 1
let g:gutentags_exclude_filetypes = ['gitcommit', 'gitconfig', 'gitrebase', 'gitsendemail', 'git', 'yaml', 'yaml.ansible']

let g:terraform_align=1
let g:terraform_fold_sections=1
let g:terraform_fmt_on_save=1

" liuchengxu/vista.vim
let g:vista_sidebar_width = 50
let g:vista_finder_alternative_executives = ['coc']
let g:vista_executive_for = {
  \   'sh':         'coc',
  \   'json':       'coc',
  \   'yaml':       'coc',
  \ }
nnoremap <silent> <Leader>_ :Vista!!<CR>
nnoremap <silent> <leader>ft :Vista finder<CR>

let g:indentLine_char='▏'
let g:indentLine_faster = 1
let g:indentLine_setConceal = 1
let g:indentLine_fileTypeExclude = ['markdown']
let g:indentLine_bufTypeExclude = ['help', 'terminal']

let g:better_whitespace_filetypes_blacklist=['gitcommit']

" undotree
nnoremap U :UndotreeToggle<cr>
let g:undotree_WindowLayout = 2

" NERDTree
noremap <leader>n :NERDTreeToggle<CR>
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeHighlightCursorline = 0
let NERDTreeMinimalUI = 1
let NERDTreeQuitOnOpen = 1
let NERDTreeShowHidden = 1

let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'

let g:nnn#layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Debug' } }

map <Leader>M :MarkedOpen<CR>

nmap p <plug>(YoinkPaste_p)
nmap P <plug>(YoinkPaste_P)

let g:gist_show_privates = 1
let g:gist_post_private = 1

let g:grepper = {}
let g:grepper.tools = ['git', 'rg']
nnoremap \ :GrepperRg<SPACE>
nnoremap K :Grepper -cword -noprompt<CR>
nmap gs <plug>(GrepperOperator)
xmap gs <plug>(GrepperOperator)

xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" }}}

" Custom commands
command! -nargs=+ S execute 'silent <args>' | redraw!
command! -nargs=* T split | resize 15 | term <args>
command! -nargs=* VT vsplit | term <args>

" No arrows in Normal mode
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

inoremap jj <Esc>
inoremap jk <Esc>
inoremap <C-space> <C-x><C-o>
nnoremap <Esc><Esc> :<C-u>nohlsearch<CR>
nmap <silent> <leader>ve :e ~/.config/nvim/init.vim<CR>
nnoremap <silent> <leader>vr :source $MYVIMRC<CR>

nnoremap <F9> :set nu! nu?<CR>

nnoremap <Leader>h :set hlsearch! hlsearch?<CR>
nmap <silent> <Leader>i :call <SID>ToggleInvisibles()<CR>
nmap <silent> <leader>k <Plug>DashSearch

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

nnoremap <leader>w :w<CR>
nnoremap <leader>x :bd<CR>
nnoremap <leader>X :bd!<CR>

nnoremap <M-Tab> <C-w>w

nnoremap <expr> <Tab> (&buftype is# "quickfix" ? "" : ":bnext<CR>")
nnoremap <expr> <S-Tab> (&buftype is# "quickfix" ? "" : ":bprev<CR>")

nnoremap <leader>Tp :set ft=python<CR>
nnoremap <leader>Ta :set ft=yaml.ansible<CR>

" Bypass capital letters
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

nnoremap <Leader>D :Dispatch<SPACE>
nnoremap <Leader>T :T<SPACE>

" toggle invisible characters
function s:ToggleInvisibles()
  if !exists('g:old_listchars')
    let g:old_listchars = &listchars
    let &listchars = &listchars.",eol:¶,tab:→\ ,space:\u00b7"
  else
    let &listchars = g:old_listchars
    unlet g:old_listchars
  endif
endfunction

" auto quit vim if main file is closed
function! s:CheckLeftBuffers()
  let filetypes = ['help', 'qf', 'nerdtree', 'vista']
  if tabpagenr('$') == 1
    let i = 1
    while i <= winnr('$')
      if index(filetypes, getbufvar(winbufnr(i), '&filetype')) >= 0
        let i += 1
      else
        break
      endif
    endwhile
    if i == winnr('$') + 1
      qall
    endif
    unlet i
  endif
endfunction

augroup vimrc
    autocmd!
    autocmd BufEnter * call s:CheckLeftBuffers()
    autocmd BufRead,BufNewFile *.json setlocal conceallevel=0 foldmethod=syntax
    autocmd BufRead,BufNewFile *.md,*.mkd,*.markdown
            \ setlocal spell ft=markdown colorcolumn=80 conceallevel=0
    autocmd FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>
    autocmd BufRead,BufNewFile *.yml,*.yaml setlocal colorcolumn=160
    autocmd BufWritePre * StripWhitespace
    autocmd BufWritePost ~/.config/nvim/init.vim source ~/.config/nvim/init.vim  | call lightline#functions#reload()
    autocmd FileType sh setlocal et ts=4 sw=4
    autocmd FileType qf setlocal nobuflisted
    autocmd FileType python nnoremap <buffer> <Leader>pi :CocCommand python.setInterpreter<CR>
    autocmd FileType python nnoremap <buffer><silent> <Leader>pe :AsyncRun! -mode=term -pos=bottom -rows=15 python "%"<CR>
    autocmd FileType python setlocal sw=4 sts=4 ts=4 et
    autocmd TermOpen term://* setlocal scrolloff=0 nonumber norelativenumber | startinsert

augroup END

" vim: set et fenc=utf-8 ft=vim sts=2 sw=2 ts=2 tw=120 :
