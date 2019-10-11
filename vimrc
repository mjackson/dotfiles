""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins

call plug#begin('~/.vim/plugs')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'wellle/targets.vim'
"Plug 'rstacruz/vim-closer'
"Plug 'Raimondi/delimitMate'
"Plug 'tpope/vim-endwise'
Plug 'jiangmiao/auto-pairs'
Plug 'ervandew/supertab'
"Plug 'lifepillar/vim-mucomplete'
Plug 'wincent/command-t', {
  \ 'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make' }
Plug 'wincent/terminus'
Plug 'sheerun/vim-polyglot'
Plug 'jxnblk/vim-mdx-js'
" Plug 'prettier/vim-prettier', {
"   \ 'do': 'yarn install' }
Plug 'mileszs/ack.vim'
Plug 'chriskempson/base16-vim'
Plug 'w0rp/ale'

call plug#end()

" Keep .swp files in uniquely-named files in $HOME/.vim/swapfiles
set directory=$HOME/.vim/swapfiles//

" Use , as <Leader>
let mapleader = ","

" Use %% on the command line to expand to the dir of the current file
cnoremap <Expr> %% expand("%:h") . "/"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Editing

" Use . in visual mode to execute the dot command on each selected line
xnoremap . :normal .<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Indenting

set tabstop=2           " use 2 char width for tabs
set shiftwidth=2        " use 2 spaces for indent

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Linting

set signcolumn=yes              " always show the signcolumn on LH side
let g:ale_set_highlights = 0    " don't highlight first char of errors

let g:ale_linters = {
\ 'javascript': ['eslint']
\}

let g:ale_fixers = {
\ 'css': ['prettier'],
\ 'javascript': ['prettier'],
\ 'json': ['prettier']
\}

let g:ale_fix_on_save = 1

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Movement

" Always move linewise in normal mode
nnoremap k gk
nnoremap j gj

" Preserve indentation when moving lines
" See http://vim.wikia.com/wiki/Moving_lines_up_or_down
nnoremap <C-j> :m .+1<Return>==
nnoremap <C-k> :m .-2<Return>==
vnoremap <C-j> :m '>+1<Return>gv=gv
vnoremap <C-k> :m '<-2<Return>gv=gv

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Split panes

set splitbelow          " open split panes on bottom (instead of top)
set splitright          " open split panes on right (instead of left)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Copy/paste

set clipboard=unnamed   " copy to the clipboard when yanking

" Re-select the last pasted text with `gp`
nnoremap gp `[v`]

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Line numbers

set number              " show line numbers

" Toggle line numbers with <Leader>n
noremap <Leader>n :set number!<Return>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Wrapping

set nowrap              " do not wrap long lines by default
set linebreak           " when wrapping, break on word boundaries

" Toggle wrapping with <Leader>w
noremap <Leader>w :set wrap!<Return>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching

set ignorecase          " ignore case when searching
set smartcase           " don't ignore case if using any uppercase
set hlsearch            " highlight matches

" Clear highlighting for the current search with <Leader>/
" Adapted from https://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting/657484#657484
nnoremap <Leader>/ :let @/ = ""<Return>

" Open :Ack with <Leader>a
nnoremap <Leader>a :Ack<Space>
vnoremap <Leader>a :Ack<Space>

" Ignore node_modules with command-t
let g:CommandTWildIgnore = &wildignore . ",*/node_modules"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Syntax

let g:jsx_ext_required = 0          " allow JSX in .js files
let g:javascript_plugin_flow = 1    " allow Flow in .js files

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Prettier

" " Make vim-prettier use prettier defaults
" let g:prettier#config#bracket_spacing = "true"
" let g:prettier#config#jsx_bracket_same_line = "false"
" let g:prettier#config#parser = "babylon"
" let g:prettier#config#single_quote = "true"
" let g:prettier#config#trailing_comma = "none"

" " Don't use vim-prettier's auto-formatting
" let g:prettier#autoformat = 0

" Run prettier async before saving
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.json,*.graphql,*.md,.babelrc,.eslintrc,.prettierrc PrettierAsync

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors

set termguicolors       " enable gui colors in the terminal

" Use current terminal color scheme for vim
if filereadable(expand("~/.vimrc_background"))
  "let base16colorspace = 256
  source ~/.vimrc_background
endif


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Netrw

" Allow netrw to remove non-empty local directories
let g:netrw_localrmdir = "trash"
