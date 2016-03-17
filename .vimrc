runtime! plugin/sensible.vim

let s:darwin = has('mac')

set nocompatible
set hidden

let mapleader = ","

set wildmode=longest,list,full
set title
set number
set mouse=a
set ttyfast
set modeline
set autowrite
set modelines=5
set completeopt-=preview
set cursorline
set clipboard=unnamed
set ignorecase
set showmode
set showmatch
"set softtabstop=4
"set tabstop=8
set gcr=a:blinkon0
set guifont=Inconsolata\ for\ Powerline:h14
set visualbell t_vb= 
set scrolloff=5
"set background=dark
set switchbuf=useopen
set novisualbell  
set splitbelow
set splitright
set directory=/tmp//
set backupdir=/tmp//

if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --column'
endif
command! -nargs=1 -bar Grep execute 'silent! grep! <q-args>' | redraw! | copen

if $TERM =~ '-256color'
	    set t_Co=256
endif

colorscheme onedark 
"colorscheme jellybeans 


call plug#begin('~/.vim/bundle')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-sleuth'

Plug 'Yggdroot/indentLine', { 'on': 'IndentLinesEnable' }
	autocmd! User indentLine doautocmd indentLine Syntax

Plug 'vim-airline/vim-airline-themes'
Plug 'vim-airline/vim-airline'
	let g:airline_theme='onedark'
	let g:airline_powerline_fonts = 1
	let g:airline_exclude_preview = 1
	let g:airline#extensions#tabline#enabled = 1
	let g:airline#extensions#tabline#formatter = 'unique_tail'
	let g:airline#extensions#tabline#left_sep = ' '
	let g:airline#extensions#tabline#left_alt_sep = '|'
	let g:airline#extensions#tabline#fnamemod = ':t'

Plug 'majutsushi/tagbar'
	nmap 	 <F8> :TagbarToggle<CR>

Plug 'scrooloose/syntastic'
	set statusline+=%#warningmsg#
	set statusline+=%{SyntasticStatuslineFlag()}
	set statusline+=%*
	let g:syntastic_always_populate_loc_list   = 1
	let g:syntastic_auto_loc_list              = 1
	let g:syntastic_check_on_open              = 0
	let g:syntastic_check_on_wq                = 1
	let g:syntastic_markdown_checkers          = ['mdl']

Plug 'scrooloose/nerdtree'
	nmap 	 <F7> :NERDTreeToggle<CR>

Plug 'vim-scripts/mru.vim'
Plug 'mhinz/vim-startify'
	let g:startify_files_number  = 8

	let g:startify_custom_header =
		\ map(split(system('fortune -s|cowsay -f milk'), '\n'), '" ". v:val') + ['']

	let g:startify_bookmarks  = [ '~/.vimrc' ]
	let g:startify_list_order = [
		\ ['   Bookmarks:'],
		\ 'bookmarks',
		\ ['   Recent files:'],
		\ 'files',
		\ ]

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

if s:darwin
Plug 'rizzatti/dash.vim', { 'on': 'Dash' }
Plug 'Keithbsmiley/investigate.vim'
	let g:investigate_use_dash=1
	let g:investigate_use_dash_for_vim=1
	let g:investigate_dash_for_ansible="ansible"
	nnoremap <leader>K :call investigate#Investigate('n')<CR>
	vnoremap <leader>K :call investigate#Investigate('v')<CR>
endif

Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
	nnoremap <F5> :UndotreeToggle<cr>
	let g:undotree_WindowLayout = 2

Plug 'maxbrunsfeld/vim-yankstack'
	nmap <leader>p <Plug>yankstack_substitute_older_paste
	nmap <leader>P <Plug>yankstack_substitute_newer_paste

Plug 'SirVer/ultisnips'
	set runtimepath+=~/.vim/my-snippets/
	let g:UltiSnipsSnippetsDir='~/.vim/my-snippets/'
	let g:UltiSnipsSnippetDirectories=["my-snippets"]
	let g:UltiSnipsEditSplit='vertical'
	let g:UltiSnipsExpandTrigger='<c-l>'
	let g:UltiSnipsListSnippets='<c-tab>'
	let g:UltiSnipsJumpForwardTrigger='<C-j>'
	let g:UltiSnipsJumpBackwardTrigger='<C-k>'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all'  }
Plug 'junegunn/fzf.vim'
	let g:fzf_layout = { 'down': '~20%'  }
	nnoremap <silent> <expr> <Leader><Leader> (expand('%') =~ 'NERD_tree' ? "\<c-w>\<c-w>" : '').":Files\<cr>"
	nnoremap <silent> <Leader><Enter>  :Buffers<CR>
	nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
	imap <c-x><c-k> <plug>(fzf-complete-word)
	imap <c-x><c-f> <plug>(fzf-complete-path)
	imap <c-x><c-j> <plug>(fzf-complete-file-ag)
	imap <c-x><c-l> <plug>(fzf-complete-line)
	inoremap <expr> <c-x><c-k> fzf#vim#complete#word({'left': '15%'})

Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'jmcantrell/vim-virtualenv', { 'for': 'python' }
Plug 'mitsuhiko/vim-python-combined', { 'for': 'python' }
Plug 'davidhalter/jedi-vim', { 'for': 'python' }
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
	map 	 <F3> :TaskList<CR>

Plug 'mattn/gist-vim' | Plug 'mattn/webapi-vim'
	let g:gist_show_privates = 1
	let g:gist_post_private = 1

Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'tpope/vim-jdaddy'

Plug 'vim-scripts/Modeliner'
	let g:Modeliner_format = 'ft=  fenc=  tw=  et  ts=  sts=  sw='

Plug 'dhruvasagar/vim-table-mode'
	let g:table_mode_corner="|"
Plug 'gabrielelana/vim-markdown' | Plug 'godlygeek/tabular'
	let g:markdown_enable_insert_mode_mappings = 0

Plug 'dbakker/vim-lint'
Plug 'chrisbra/vim-diff-enhanced'
	if &diff
		    let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
	endif

Plug 'tpope/vim-endwise'
Plug 'terryma/vim-multiple-cursors'
Plug 'Shougo/neocomplete.vim'

Plug 'Shougo/vimshell.vim' | Plug 'Shougo/vimproc.vim', { 'do': 'make -f make_mac.mak'  }
	let g:vimshell_prompt= '$ '

Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'pearofducks/ansible-vim'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'godlygeek/csapprox'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'rking/ag.vim'
Plug 'nvie/vim-togglemouse'
Plug 'vim-scripts/DrawIt'
Plug 'manicmaniac/ftcompl'
Plug 'tmux-plugins/vim-tmux'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'ktonga/vim-follow-my-lead'
	let g:fml_all_sources=1

call plug#end()

call yankstack#setup()


inoremap jj <Esc>
inoremap <C-space> <C-x><C-o>
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

nnoremap \ :Ag<SPACE>

set pastetoggle=<F2>
nnoremap <F2> :set invpaste paste?<CR>
nnoremap <F9> :set nu! nu?<CR>

nnoremap <Leader>h :set hlsearch! hlsearch?<CR>
nnoremap <Leader>n :set number! number?<CR>

nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

nnoremap ]b :bnext<cr>
nnoremap [b :bprev<cr>

nnoremap <leader>Th :set ft=htmljinja<CR>
nnoremap <leader>Tp :set ft=python<CR>
nnoremap <leader>Tj :set ft=javascript<CR>
nnoremap <leader>Tc :set ft=css<CR>
nnoremap <leader>Ta :set ft=ansible<CR>

nnoremap <leader>m :silent !open -a Marked\ 2.app '%:p'<cr>

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
	autocmd BufWritePost $MYVIMRC source $MYVIMRC | AirlineRefresh
	autocmd FileType ruby,python,javascript,c,cpp set nowrap
	autocmd FileType ruby,python,javascript,c,cpp set colorcolumn=85
	autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
	autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
	autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
	autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
	autocmd FileType python setlocal completeopt-=preview
	autocmd FileType python map <buffer> <leader>8 :PymodeLint<CR>
	autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
augroup END
