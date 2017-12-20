call plug#begin('~/.vim/plugs')

Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-commentary'
Plug 'mileszs/ack.vim'
Plug 'vim-airline/vim-airline'
Plug 'ervandew/supertab'
Plug 'wincent/command-t', {
  \ 'do': 'cd ruby/command-t/ext/command-t && ruby extconf.rb && make' }
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown'] }
Plug 'chriskempson/base16-vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'

call plug#end()

" Do not wrap long lines
set nowrap

" Highlight the line with the cursor
set cursorline

" Show line numbers
set number

" Indent using spaces instead of tabs
set expandtab

" The number of spaces to use for each indent
set shiftwidth=2

" Number of spaces to use for a <Tab> during editing operations
set softtabstop=2

" Enable the mouse for all modes
set mouse=a

" Keep .swp files in uniquely-named files in $HOME/.vim
set directory=$HOME/.vim/swapfiles//

set termguicolors

if filereadable(expand("~/.vimrc_background"))
  "let base16colorspace=256
  source ~/.vimrc_background
endif

let mapleader=","

" Use babylon parser with prettier
let g:prettier#config#parser="babylon"
" Run prettier asynchronously before saving
let g:prettier#autoformat=0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md PrettierAsync

" Use JSON in .babelrc files
autocmd BufRead,BufNewFile .babelrc setfiletype json

" Allow JSX in .js files
let g:jsx_ext_required=0

" Ignore node_modules with command-t
let g:CommandTWildIgnore=&wildignore . ",*/node_modules"

" Highlight search matches
set hlsearch
" Clear highlighting for the current search with <Leader>/
" Adapted from https://stackoverflow.com/questions/657447/vim-clear-last-search-highlighting/657484#657484
nnoremap <Leader>/ :let @/=""<return>

" Mappings for moving lines and preserving indentation
" See http://vim.wikia.com/wiki/Moving_lines_up_or_down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Use %% on the command line to expand to the dir of the current file
cnoremap %% <C-R>=fnameescape(expand("%:h")) . "/" <CR>

" Mappings for quickly opening files
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

if $TERM_PROGRAM =~ "iTerm"
  " Close command-t using <ESC>
  let g:CommandTCancelMap=["<Esc>", "<C-c>"]

  " Change cursor shape in iTerm2.app
  let &t_SI = "\<Esc>]50;CursorShape=1\x7" " Bar in insert mode
  let &t_SR = "\<Esc>]50;CursorShape=2\x7" " Underline in replace mode
  let &t_EI = "\<Esc>]50;CursorShape=0\x7" " Block in normal mode
elseif &term =~# "xterm"
  " Change cursor shape in xterm
  let &t_SI="\<Esc>[5 q" " Blinking bar in insert mode
  let &t_SR="\<Esc>[1 q" " Blinking block in replace mode
  let &t_EI="\<Esc>[2 q" " Block in normal mode
endif
