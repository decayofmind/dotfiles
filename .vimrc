runtime! plugin/sensible.vim

let s:darwin = has('macunix')
let g:has_async = v:version >= 800 || has('nvim')
let g:python3_host_prog = '/usr/local/bin/python3.7'
let g:mapleader = " "

if has('gui_running')
    if has('gui_macvim')
        set guifont=Inconsolata-dz\ for\ Powerline\ Nerd\ Font\ Plus\ Font\ Awesome\ Plus\ Octicons:h12
    else
        set guifont=Inconsolata-dz\ for\ Powerline\ Medium\ 12
    endif

    set background=light
    " Hide scrollbars
    set guioptions-=r
    set guioptions-=R
    set guioptions-=l
    set guioptions-=L
    " Hide menubar
    set guioptions-=m
    set guioptions-=T
else
    set background=dark
endif

if has('multi_byte')
  if &termencoding == ""
    let &termencoding = &encoding
  endif
  set encoding=utf-8
  setglobal fileencoding=utf-8
  "setglobal bomb
  set fileencodings=ucs-bom,utf-8,latin1
endif

if &compatible
  set nocompatible
end

set wildmode=longest,list,full
set title
set number
set mouse=a
set ttyfast
set modeline
set exrc
set autowrite
set modelines=5
set completeopt=noinsert,menuone,noselect
set cursorline
set clipboard=unnamed,unnamedplus
set ignorecase
set showmode
set showmatch
set expandtab
set smarttab
set softtabstop=2
set tabstop=2
set shiftwidth=2
set hidden
set gcr=a:blinkon0
set visualbell t_vb=
set scrolloff=5
set switchbuf=useopen
set novisualbell
set splitbelow
set splitright
set updatetime=300
set directory=/tmp//
set backupdir=/tmp//
set path+=**

set fillchars+=vert:│

if executable('rg')
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden\ --follow\ --multiline-dotall
  let g:ackprg = 'rg -S --no-heading --vimgrep'
endif
command! -nargs=1 -bar Grep execute 'silent! grep! <q-args>' | redraw! | copen

if $TERM =~ '-256color'
  set t_Co=256
endif


" Install Plug
let vimplug_exists=expand('~/.vim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

call plug#begin('~/.vim/bundle')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-dispatch'
    nnoremap <Leader>D :Dispatch<SPACE>


" Linting
if g:has_async
    Plug 'dense-analysis/ale'
endif

" Completion
if g:has_async
    Plug 'ncm2/ncm2'
    Plug 'roxma/nvim-yarp'
    Plug 'roxma/vim-hug-neovim-rpc'
        autocmd BufEnter * call ncm2#enable_for_buffer()
    Plug 'ncm2/ncm2-jedi'
    Plug 'ncm2/ncm2-path'
    Plug 'ncm2/ncm2-bufword'
endif

" Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }
Plug 'Yggdroot/indentLine'
    autocmd! User indentLine doautocmd indentLine Syntax
    let g:indentLine_char='⎸'
    let g:indentLine_faster = 1
    let g:indentLine_setConceal = 1

Plug 'ntpeters/vim-better-whitespace'
    let g:better_whitespace_filetypes_blacklist=['gitcommit']

Plug 'vim-airline/vim-airline'
    let g:airline_theme='jellybeans'
    let g:airline_powerline_fonts = 1
    let g:airline_exclude_preview = 1
    let g:airline_left_sep=' '
    let g:airline_right_sep=' '
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#formatter = 'unique_tail'
    let g:airline#extensions#tabline#left_sep = ' '
    let g:airline#extensions#tabline#right_sep = ' '
    let g:airline#extensions#tabline#left_alt_sep = '|'
    let g:airline#extensions#tabline#fnamemod = ':t'
Plug 'vim-airline/vim-airline-themes'

Plug 'majutsushi/tagbar'
    nmap <F8> :TagbarToggle<CR>
    let g:tagbar_type_ansible = {
        \ 'ctagstype' : 'ansible',
        \ 'kinds' : [
            \ 't:tasks'
        \
        \ ],
        \ 'sort' : 0
        \
    \}

Plug 'decayofmind/ListToggle'

Plug 'embear/vim-localvimrc'
Plug 'editorconfig/editorconfig-vim'
Plug 'darfink/vim-plist'

Plug 'scrooloose/nerdtree'
    nmap     <F7> :NERDTreeToggle<CR>
Plug 'Xuyuanp/nerdtree-git-plugin', { 'on': 'NERDTreeToggle' }
    let g:NERDTreeUpdateOnCursorHold = 0
    let g:NERDTreeUpdateOnWrite = 0

Plug 'vim-scripts/mru.vim'

Plug 'luochen1990/rainbow'
    let g:rainbow_active = 1
    let g:rainbow_conf = {
    \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
    \   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
    \   'operators': '_,\;\=_',
    \   'separately': {
    \       '*' : {},
    \       'vim': {
    \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
    \   },
    \       'ansible': 0,
    \       'ansible_template': 0,
    \   }
    \ }


Plug 'KabbAmine/zeavim.vim', {'on': [
    \   'Zeavim', 'Docset',
    \   '<Plug>Zeavim',
    \   '<Plug>ZVVisSelection',
    \   '<Plug>ZVKeyDocset',
    \   '<Plug>ZVMotion'
    \ ]}


if s:darwin
Plug 'rizzatti/dash.vim', { 'on': 'Dash' }
Plug 'Keithbsmiley/investigate.vim'
    let g:investigate_use_dash=1
    let g:investigate_use_dash_for_vim=1
    let g:investigate_dash_for_ansible="ansible"
    let g:investigate_dash_for_ansible_template="ansible"
    nnoremap <leader>K :call investigate#Investigate('n')<CR>
    xnoremap <leader>K :call investigate#Investigate('v')<CR>
endif

Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
    nnoremap <F5> :UndotreeToggle<cr>
    let g:undotree_WindowLayout = 2

"Plug 'maxbrunsfeld/vim-yankstack'
    "nmap <leader>p <Plug>yankstack_substitute_older_paste
    "nmap <leader>P <Plug>yankstack_substitute_newer_paste

Plug 'svermeulen/vim-easyclip'
    let g:EasyClipShareYanks = 1
    let g:EasyClipEnableBlackHoleRedirect = 0

"Plug 'SirVer/ultisnips'
    "set runtimepath+=~/.vim/my-snippets/
    "let g:UltiSnipsSnippetsDir='~/.vim/my-snippets/'
    "let g:UltiSnipsSnippetDirectories=["my-snippets"]
    "let g:UltiSnipsEditSplit='vertical'
    "let g:UltiSnipsExpandTrigger='<c-l>'
    "let g:UltiSnipsListSnippets='<c-tab>'
    "let g:UltiSnipsJumpForwardTrigger='<C-j>'
    "let g:UltiSnipsJumpBackwardTrigger='<C-k>'

" Fuzzy-finder
if isdirectory('/usr/local/opt/fzf')
  Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
else
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
endif

let g:fzf_layout = { 'down': '~20%'  }
nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>rg       :Ack <C-R><C-W><CR>
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)
inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

Plug 'junegunn/vim-peekaboo'

Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
Plug 'mitsuhiko/vim-python-combined', { 'for': 'python' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
    let g:jedi#completions_enabled = 0
    let g:jedi#popup_select_first = 0
Plug 'klen/python-mode', { 'for': 'python' }
    let g:pymode_rope = 0
    let g:pymode_rope_completion = 0
    let g:pymode_rope_complete_on_dot = 0
    let g:pymode_doc = 1
    let g:pymode_doc_key = 'K'
    let g:pymode_lint = 1
    let g:pymode_lint_checker = "pyflakes,pep8"
    let g:pymode_lint_ignore="E501,W601,C0110"
    let g:pymode_lint_write = 1
    let g:pymode_virtualenv = 1
    let g:pymode_breakpoint = 0
    let g:pymode_breakpoint_key = '<leader>d'
    let g:pymode_syntax = 1
    let g:pymode_syntax_all = 1
    let g:pymode_syntax_indent_errors = g:pymode_syntax_all
    let g:pymode_syntax_space_errors = g:pymode_syntax_all
    let g:pymode_folding = 1
    let g:pymode_run = 0

Plug 'fisadev/FixedTaskList.vim'
    map  <F3> :TaskList<CR>

Plug 'mattn/gist-vim' | Plug 'mattn/webapi-vim'
    let g:gist_show_privates = 1
    let g:gist_post_private = 1

Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'tpope/vim-jdaddy'

Plug 'WolfgangMehner/bash-support', { 'for': 'sh' }

Plug 'vim-scripts/Modeliner'
    map <Leader>ml :Modeliner<CR>
    let g:Modeliner_format = 'ft=  fenc=  tw=  et  ts=  sts=  sw='

Plug 'dhruvasagar/vim-table-mode'
    let g:table_mode_corner="|"

"Plug 'plasticboy/vim-markdown' | Plug 'godlygeek/tabular'
    "let g:vim_markdown_folding_disabled = 1
"Plug 'mzlogin/vim-markdown-toc'

Plug 'gabrielelana/vim-markdown' | Plug 'godlygeek/tabular'
    let g:markdown_enable_insert_mode_mappings = 0

" Align GitHub-flavored Markdown tables
Plug 'junegunn/vim-easy-align'
    au FileType markdown vmap <Leader><Bslash> :EasyAlign*<Bar><Enter>

if s:darwin
Plug 'itspriddle/vim-marked'
    map <Leader>M :MarkedOpen<CR>
else
Plug 'iamcco/markdown-preview.vim'
    let g:mkdp_path_to_chrome = "firefox"
    map <Leader>M :MarkdownPreview<CR>
endif

Plug 'dbakker/vim-lint'
Plug 'ynkdir/vim-vimlparser'

Plug 'chrisbra/vim-diff-enhanced'
    if &diff
        let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
    endif

Plug 'tpope/vim-endwise'
Plug 'terryma/vim-multiple-cursors'

" Plug 'Shougo/vimshell.vim' | Plug 'Shougo/vimproc.vim', { 'do': 'make -f make_mac.mak'  }
"     let g:vimshell_prompt= '$ '

Plug 'Shougo/deol.nvim'

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'pearofducks/ansible-vim'
Plug 'towolf/vim-helm'
Plug 'airblade/vim-gitgutter'
    let g:gitgutter_grep = 'rg'
    " let g:gitgutter_map_keys                = 0
    " let g:gitgutter_sign_added              = '▎'
    " let g:gitgutter_sign_modified           = '▎'
    " let g:gitgutter_sign_modified_removed   = '▶'
    " let g:gitgutter_sign_removed            = '▶'
    " let g:gitgutter_sign_removed_first_line = '◥'
    " nmap [g <Plug>GitGutterPrevHunkzz
    " nmap ]g <Plug>GitGutterNextHunkzz
    " nmap <Leader>p <Plug>GitGutterPreviewHunk
    " nmap <Leader>+ <Plug>GitGutterStageHunk
    " nmap <Leader>- <Plug>GitGutterUndoHunk

Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'godlygeek/csapprox'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
    let g:NERDSpaceDelims = 1
    let g:NERDDefaultAlign = 'left'
Plug 'nvie/vim-togglemouse'
Plug 'vim-scripts/DrawIt'
Plug 'manicmaniac/ftcompl'

Plug 'tmux-plugins/vim-tmux'
Plug 'tmux-plugins/vim-tmux-focus-events'

Plug 'syngan/vim-vimlint' | Plug 'ynkdir/vim-vimlparser'

Plug 'amiorin/vim-fasd' | Plug 'tomtom/tlib_vim'

Plug 'mileszs/ack.vim'
Plug 'mhinz/vim-grepper'
    let g:grepper = {}
    let g:grepper.tools = ["rg"]
    runtime autoload/grepper.vim
    let g:grepper.jump = 1
    nnoremap <Leader>g :GrepperRg<Space>
    nnoremap gr :Grepper -cword -noprompt<CR>
    xmap gr <plug>(GrepperOperator)

Plug 'markcornick/vim-bats'
Plug 'mhinz/vim-hugefile'
Plug 'junegunn/goyo.vim'

Plug 'ryanoasis/vim-devicons'

Plug 'hashivim/vim-terraform'
Plug 'vim-syntastic/syntastic'
Plug 'juliosueiras/vim-terraform-completion'

"color themes
Plug 'stulzer/heroku-colorscheme'
Plug 'tomasr/molokai'
Plug 'chriskempson/base16-vim'
Plug 'ajh17/Spacegray.vim'
Plug 'altercation/vim-colors-solarized'
Plug 'nanotech/jellybeans.vim'
Plug 'crusoexia/vim-monokai'
Plug 'w0ng/vim-hybrid'
    let g:hybrid_custom_term_colors = 1
    "let g:hybrid_reduced_contrast = 1
Plug 'joshdick/onedark.vim'
Plug 'jordwalke/flatlandia'

call plug#end()

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

"call yankstack#setup()

inoremap jj <Esc>
inoremap <C-space> <C-x><C-o>
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

nnoremap \ :Ack<SPACE>

set pastetoggle=<F2>
nnoremap <F2> :set invpaste paste?<CR>
nnoremap <F9> :set nu! nu?<CR>

nnoremap <Leader>h :set hlsearch! hlsearch?<CR>
nnoremap <Leader>n :set number! number?<CR>

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

nnoremap <M-Tab> <C-w>w

nnoremap ]b :bnext<CR>
nnoremap [b :bprev<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprev<CR>

nnoremap <leader>Th :set ft=htmljinja<CR>
nnoremap <leader>Tp :set ft=python<CR>
nnoremap <leader>Tj :set ft=javascript<CR>
nnoremap <leader>Tc :set ft=css<CR>
nnoremap <leader>Ta :set ft=ansible<CR>

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

augroup vimrc_autocmds
    autocmd!

    "autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
    "autocmd StdinReadPre * let s:std_in=1
    "autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
    "autocmd FileType ruby,python,javascript,c,cpp highlight Excess ctermbg=DarkGrey guibg=Black
    "autocmd FileType ruby,python,javascript,c,cpp match Excess /\%80v.*/

    autocmd BufRead,BufNewFile *.md,*.mkd,*.markdown setlocal spell
            \ ft=markdown colorcolumn=80
    autocmd FileType markdown setlocal spell
    autocmd BufWritePre * StripWhitespace
    autocmd BufWritePost $MYVIMRC source $MYVIMRC | AirlineRefresh
    autocmd FileType ruby,python,javascript,c,cpp set nowrap
    autocmd FileType ruby,python,javascript,c,cpp set colorcolumn=85
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType python setlocal completeopt-=preview
    autocmd FileType python map <buffer> <leader>8 :PymodeLint<CR>
    autocmd FileType sh set et ts=4 sw=4
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END

com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"
nnoremap = :FormatXML<Cr>

" Open current file with app given
function! s:OpenWith(appname)
  noautocmd silent execute "!open -a \"" . a:appname . "\" " . expand("%:p")
  if v:shell_error
    echohl Error
    echon "Problem opening the file."
    echohl Normal
  endif
endfunction

command! -bar -nargs=1 OpenWith call s:OpenWith(<f-args>)
command! -nargs=+ S execute 'silent <args>' | redraw!

" vim: set et fenc=utf-8 ft=vim sts=4 sw=4 ts=4 tw=78 :
