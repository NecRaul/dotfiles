let mapleader = "\<Space>"

" Download and start plug if it's not downloaded
if ! filereadable(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim"'))
    silent !mkdir -p ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/
    silent !curl "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" > ${XDG_CONFIG_HOME:-$HOME/.config}/nvim/autoload/plug.vim
    autocmd VimEnter * PlugInstall
endif

" Plug
call plug#begin(system('echo -n "${XDG_CONFIG_HOME:-$HOME/.config}/nvim/plugged"'))
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'barrett-ruth/live-server.nvim'
Plug 'bling/vim-bufferline'
Plug 'dylanaraps/wal.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-tree/nvim-tree.lua'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'OmniSharp/omnisharp-vim'
Plug 'psf/black'
Plug 'rbong/vim-flog'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'windwp/nvim-autopairs'
Plug 'Yggdroot/indentLine'
call plug#end()

" Basic settings
set title
set autoindent
set bg=dark
set go=a
set mouse=a
set nohlsearch
set clipboard+=unnamedplus
set updatetime=100
set noshowmode
set noruler
set laststatus=0
set noshowcmd
set encoding=utf-8
set number
set expandtab
set tabstop=4
set shiftwidth=4
set splitbelow splitright
set nocompatible
filetype plugin indent on
syntax on

" Keybindings
nnoremap <silent><C-Left> <C-w>h
nnoremap <silent><C-Down> <C-w>j
nnoremap <silent><C-Up> <C-w>k
nnoremap <silent><C-Right> <C-w>l
nnoremap <C-n> :edit<Space>
nnoremap <silent><C-w> :w<CR>
nnoremap <silent><C-q> :q<CR>
nnoremap <leader>q :w<CR>:bd<CR>:bn<CR>
nnoremap <leader>Q :bd!<CR>:bn<CR>
nnoremap <silent><leader><Left> :bp<CR>
nnoremap <silent><leader><Right> :bn<CR>
nnoremap <silent><C-t> :NvimTreeToggle<CR>
nnoremap <silent><C-d> :GitGutterDiffOrig<CR>
nnoremap <silent><C-l> :Flog<CR>
nnoremap <silent><C-o> :setlocal spell! spelllang=en_us<CR>
nnoremap <silent><C-v> :vsp<CR>
nnoremap <silent><C-h> :sp<CR>
nnoremap <silent><C-f> :Telescope find_files<CR>
nnoremap <silent><C-s> :Telescope live_grep<CR>
nnoremap <leader>s :%s//<Left>

" CoC Keybindings
" Use tab for trigger completion with characters ahead and navigate
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" CoC Extensions
let g:coc_global_extensions =
  \[
  \  '@yaegassy/coc-volar',
  \  'coc-clangd',
  \  'coc-css',
  \  'coc-cssmodules',
  \  'coc-docker',
  \  'coc-eslint',
  \  'coc-go',
  \  'coc-html',
  \  'coc-html-css-support',
  \  'coc-java',
  \  'coc-json',
  \  'coc-lua',
  \  'coc-prettier',
  \  'coc-pyright',
  \  'coc-sh',
  \  'coc-sql',
  \  'coc-tsserver',
  \  'coc-xml',
  \  'coc-yaml'
  \]

" OmniSharp
let g:OmniSharp_server_use_net6 = 1

" Black format on save for Python
autocmd BufWritePre *.py execute ':Black'
" Prettier format on save for appropriate files
autocmd BufWritePre *.js,*.jsx,*.vue,*.mjs,*.ts,*.tsx,*.json,*.css,*.scss,*.html,*.yaml CocCommand prettier.formatFile

" Airline settings
let g:bufferline_echo = 0
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#hunks#enabled=1
let g:airline_experimental = 1
let g:airline_detect_modified=1
let g:airline_detect_paste=1
let g:airline_detect_crypt=1
let g:airline_detect_spell=1
let g:airline_detect_spelllang=1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#right_sep = ' '
let g:airline#extensions#tabline#right_alt_sep = '|'
let g:airline_left_sep = ' ◀'
let g:airline_right_sep = '▶ '
let g:airline_left_alt_sep = '«'
let g:airline_right_alt_sep = ' » '
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.branch = ''
let g:airline_symbols.linenr = ' ¶'
let g:airline_symbols.maxlinenr = '☰ '
let g:airline_symbols.colnr = ' cn:'
let g:airline_symbols.dirty=' ⚡'
let g:airline_symbols.notexists = ' ∄'
let g:airline_symbols.whitespace = 'Ξ'
let g:airline_filetype_overrides = {
      \ 'coc-explorer':  [ 'CoC Explorer', '' ],
      \ 'defx':  ['defx', '%{b:defx.paths[0]}'],
      \ 'fugitive': ['fugitive', '%{airline#util#wrap(airline#extensions#branch#get_head(),80)}'],
      \ 'floggraph':  [ 'Flog', '%{get(b:, "flog_status_summary", "")}' ],
      \ 'gundo': [ 'Gundo', '' ],
      \ 'help':  [ 'Help', '%f' ],
      \ 'minibufexpl': [ 'MiniBufExplorer', '' ],
      \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', 'NERD'), '' ],
      \ 'startify': [ 'startify', '' ],
      \ 'vim-plug': [ 'Plugins', '' ],
      \ 'vimfiler': [ 'vimfiler', '%{vimfiler#get_status_string()}' ],
      \ 'vimshell': ['vimshell','%{vimshell#get_status_string()}'],
      \ 'vaffle' : [ 'Vaffle', '%{b:vaffle.dir}' ],
      \ 'NvimTree' : [ 'NvimTree', '']
      \ }
let g:airline_theme='wal'
colorscheme wal

" Indent Line settings
let g:indentLine_char='¦'
let g:indentLine_setColors = 0

" Automatically deletes all trailing whitespace and newlines at end of file on save.
autocmd BufWritePre * let currPos = getpos('.')
autocmd BufWritePre * %s/\s\+$//e
autocmd BufWritePre * %s/\n\+\%$//e
autocmd BufWritePre *.[ch] %s/\%$/\r/e
autocmd BufWritePre * cal cursor(currPos[1], currPos[2])

" Run xrdb whenever Xdefaults or Xresources are updated.
autocmd BufRead,BufNewFile Xresources,Xdefaults,xresources,xdefaults set filetype=xdefaults
autocmd BufWritePost Xresources,Xdefaults,xresources,xdefaults !xrdb %
" Recompile dwmblocks on config edit.
autocmd BufWritePost ~/Documents/Github/Repos/dwmblocks/config.h !cd ~/Downloads/Github/Repos/dwmblocks/; sudo make install && { killall -q dwmblocks;setsid dwmblocks & }

" Lua section
lua << EOF
  require("live-server").setup()
  require('nvim-tree').setup{
  filters = {
    git_ignored = false,
    custom = { '.git' },
  },
  view = {
      side = "left",
      width = 40,
    },
    hijack_cursor = true,
    sync_root_with_cwd = true,
    update_focused_file = {
      enable = true,
      update_root = false,
    },
    renderer = {
      group_empty = true,
      highlight_git = true,
      highlight_modified = 'all',
      root_folder_modifier = '~',
      indent_markers = {
        enable = true,
      },
    },
  }
  require('nvim-web-devicons').setup()
  require('nvim-treesitter.configs').setup {
    ensure_installed = {
      'bash',
      'c',
      'c_sharp',
      'cmake',
      'comment',
      'css',
      'diff',
      'dockerfile',
      'gdscript',
      'git_config',
      'git_rebase',
      'gitattributes',
      'gitcommit',
      'gitignore',
      'go',
      'gomod',
      'gosum',
      'html',
      'http',
      'ini',
      'java',
      'javascript',
      'json',
      'lua',
      'make',
      'markdown',
      'python',
      'requirements',
      'sql',
      'typescript',
      'xml',
      'yaml'
    },
    auto_install = true,
    highlight = {
      enable = true,
    },
    indent = {
      enable = true,
    },
  }
  require("nvim-autopairs").setup()
EOF
