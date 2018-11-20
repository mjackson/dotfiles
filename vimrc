""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins

call plug#begin('~/.vim/plugs')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
Plug 'mileszs/ack.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'ervandew/supertab'
Plug 'wincent/command-t', {
  \ 'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make' }
Plug 'wincent/terminus'
Plug 'sheerun/vim-polyglot'
Plug 'prettier/vim-prettier', {
      \ 'do': 'yarn install',
      \ 'for': ['javascript', 'typescript', 'css', 'json', 'graphql', 'markdown'] }
Plug 'chriskempson/base16-vim'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Behaviors

" Keep .swp files in uniquely-named files in $HOME/.vim/swapfiles
set directory=$HOME/.vim/swapfiles//

" Show line numbers
set number

" Highlight the line with the cursor
set cursorline

" Enable yanking to the clipboard
set clipboard=unnamed

" Wrap long lines on word boundaries
set wrap linebreak

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key Mappings

" Use , as mapleader
let mapleader=","

" Preserve indentation when moving lines
" See http://vim.wikia.com/wiki/Moving_lines_up_or_down
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Adjust movement keys when wrapping
noremap  <buffer> <silent> k gk
noremap  <buffer> <silent> j gj
noremap  <buffer> <silent> 0 g0
noremap  <buffer> <silent> $ g$

" Mappings for quickly opening files
map <Leader>ew :e %%
map <Leader>es :sp %%
map <Leader>ev :vsp %%
map <Leader>et :tabe %%

" Use %% on the command line to expand to the dir of the current file
cnoremap %% <C-R>=fnameescape(expand("%:h")) . "/" <CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Searching

" Highlight search matches
set hlsearch

" Clear highlighting for the current search with <Leader>/
" Adapted from https://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting/657484#657484
nnoremap <Leader>/ :let @/=""<Return>

" Ignore node_modules with command-t
let g:CommandTWildIgnore=&wildignore . ",*/node_modules"

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" File types

augroup filetypes
  " Use JSON in .babelrc files
  autocmd BufRead,BufNewFile .babelrc,.eslintrc,.prettierrc setfiletype json
augroup END

" Allow JSX in .js files
let g:jsx_ext_required=0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Colors

" Enable gui colors in the terminal
set termguicolors

" Use current terminal color scheme for vim
if filereadable(expand("~/.vimrc_background"))
  "let base16colorspace=256
  source ~/.vimrc_background
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Prettier

" Don't use prettier's auto-formatting
let g:prettier#autoformat=0

augroup prettier
  " Run prettier before saving
  autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,.babelrc,.eslintrc,.prettierrc Prettier
augroup END

" Make vim-prettier use prettier defaults
let g:prettier#config#bracket_spacing="true"
let g:prettier#config#jsx_bracket_same_line="false"
let g:prettier#config#parser="babylon"
let g:prettier#config#single_quote="true"
let g:prettier#config#trailing_comma="none"
