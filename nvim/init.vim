" Options Standards de Vim

syntax on
set termguicolors
set mouse=
set tabstop=4
set nowrap
set number
set fileencoding=utf-8
set listchars=tab:\|\ 
set list
set noerrorbells
set smartindent
set noswapfile
set nobackup
set undodir=~/.vim/undodir
set undofile
set noexpandtab
set scrolloff=8
set relativenumber
set shiftwidth=4
set softtabstop=4
set nohlsearch 
set noshowmode
let g:polyglot_disabled = ["svelte"]

" Remap Standards
inoremap jk <Esc>
nnoremap <Tab><Tab> :%retab!<CR>gg=G
vnoremap <C-c> <Esc>

" Remap de mouvement pour clavier Azerty
nnoremap j h
nnoremap k j
nnoremap l k
nnoremap m l
nnoremap h m
nnoremap ù 0
nnoremap <CR> o<Esc>

vnoremap j h
vnoremap k j
vnoremap l k
vnoremap m l
vnoremap h m
vnoremap ù 0

nnoremap <C-w>j <C-w>h
nnoremap <C-w>k <C-w>j
nnoremap <C-w>l <C-w>k
nnoremap <C-w>m <C-w>l
nnoremap <C-w>h <C-w>m

" Remap pour le terminal
tnoremap jk <c-\><c-n> 
nnoremap <space>t :tabnew<CR>:terminal<CR>

" Remap pour les tabs
nnoremap <Left> gT
nnoremap <Right> gt
nnoremap <Up> :tabm +1<CR>
nnoremap <Down> :tabm -1<CR>
nnoremap <S-tab> :tabnew<CR>:Telescope find_files<CR>

" Remap des plugins
map ^ :call NERDComment(0, "toggle")<CR>
nnoremap <space>e :NvimTreeToggle<CR>
nnoremap <space>p :CtrlPBuffer<CR>
nnoremap <space>b :Telescope buffers show_all_buffers=true<CR>
nnoremap <space>f :Telescope find_files<CR>
nnoremap <space>h :Telescope help_tags<CR>
nnoremap <space>c :Telescope colorscheme<CR>
nnoremap <space>g :Telescope live_grep<CR>
nnoremap <space>i :Telescope current_buffer_fuzzy_find<CR>
nnoremap <space>v :Vista<CR>
nnoremap <space>V :Vista!<CR>
nnoremap <space>u :UndotreeToggle<CR>
nnoremap <space>sv :vsplit<CR><C-w>l:Telescope find_files<CR>
nnoremap <space>sh :split<CR><C-w>j:Telescope find_files<CR>
nnoremap <space>d :CtrlPDigraphs<CR>
nnoremap <space>w :Goyo<CR>
nnoremap <space>W :Goyo!<CR>:so ~/.config/nvim/init.vim<CR>:AirlineTheme shades_of_purple<CR>


" Plugins 
call plug#begin(stdpath('config'). '/plugged/')

" Themes
Plug 'cocopon/iceberg.vim'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'Rigellute/shades-of-purple.vim'
Plug 'artanikin/vim-synthwave84'

" Plugins pour le développement
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'evanleck/vim-svelte'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'preservim/nerdcommenter'
Plug 'liuchengxu/vista.vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kyazdani42/nvim-web-devicons'
Plug 'glepnir/dashboard-nvim'
Plug 'rrethy/vim-hexokinase', { 'do': 'make' }
Plug 'kyazdani42/nvim-tree.lua'
Plug 'mbbill/undotree'
Plug '907th/vim-auto-save'
Plug 'naquad/ctrlp-digraphs.vim'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'

call plug#end()

" Activation du thème + fond transparent
colorscheme iceberg
hi Normal guibg=none
hi Comment gui=italic cterm=italic term=italic

" Thème pour Airline
autocmd VimEnter * AirlineTheme shades_of_purple

" Options Hexokinase
let g:Hexokinase_highlighters = ['backgroundfull']

" Options Airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
let g:airline_skip_empty_sections = 1
let g:airline#extensions#whitespace#enabled = 0
let g:airline#extensions#tabline#formatter = 'unique_tail'
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

let g:airline_symbols.linenr = '(╯°□°)╯︵ ┻━┻ '
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:one_allow_italics = 1

" Options coc.nvim pour utiliser TAB
inoremap <silent><expr> <TAB>
	  \ pumvisible() ? coc#_select_confirm() :
	  \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
	  \ <SID>check_back_space() ? "\<TAB>" :
	  \ coc#refresh()

function! s:check_back_space() abort
	  let col = col('.') - 1
		return !col || getline('.')[col - 1]  =~# '\s'
	endfunction

let g:coc_snippet_next = '<tab>'

" Options pour Vista
let g:vista_default_executive = "coc"
let g:vista#renderer#enable_icon = 1

" Options pour CtrlP + function de suppression de buffers
let g:ctrlp_buffer_func = { 'enter': 'CtrlPBDelete' }

function! CtrlPBDelete()
  nnoremap <buffer> <silent> <c-del> :call <sid>DeleteMarkedBuffers()<cr>
endfunction

function! s:DeleteMarkedBuffers()
  " list all marked buffers
  let marked = ctrlp#getmarkedlist()

  " the file under the cursor is implicitly marked
  if empty(marked)
    call add(marked, fnamemodify(ctrlp#getcline(), ':p'))
  endif

  " call bdelete on all marked buffers
  for fname in marked
    let bufid = fname =~ '\[\d\+\*No Name\]$' ? str2nr(matchstr(fname, '\d\+'))
          \ : fnamemodify(fname[2:], ':p')
    exec "silent! bdelete" bufid
  endfor

  " refresh ctrlp
  exec "normal \<F5>"
endfunction

" Options de dashboard
let g:dashboard_default_executive ='telescope'
let g:dashboard_preview_command="cat"
let g:dashboard_preview_file="~/.config/nvim/dashboard"
let g:dashboard_preview_pipeline="lolcat"
let g:dashboard_preview_file_width=70
let g:dashboard_preview_file_height=10

" Options de nvim_tree
let g:nvim_tree_width = 25
let g:nvim_tree_auto_close = 1
let g:nvim_tree_quit_on_open = 1
let g:nvim_tree_indent_markers = 1

" Options de undotree
let g:undotree_ShortIndicators = 1
let g:undotree_SetFocusWhenToggle = 1

" Options de auto_save
let g:auto_save = 1

let g:goyo_width = 100

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!
let g:limelight_conceal_guifg = '#3a3a3a'



