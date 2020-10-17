if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
" --------
   " Theme
   " --------
   " Plug 'joshdick/onedark.vim'
   " Plug 'w0ng/vim-hybrid'
   " Plug 'sjl/badwolf'
   " Plug 'rakr/vim-one'
   " Plug 'dracula/vim'
   Plug 'morhetz/gruvbox'

   " File Browser
   Plug 'scrooloose/nerdtree'

   " Fuzzy Search
   " Plug 'kien/ctrlp.vim'
   " Plug '/Users/chris/.fzf'
   Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
   Plug 'junegunn/fzf.vim'

   " Plug 'Yggdroot/indentLine'
   " Plug 'kien/rainbow_parentheses.vim'
   " Plug 'luochen1990/rainbow'

   " Git stuff
   Plug 'tpope/vim-fugitive'

   " Plug 'tpope/vim-markdown'

   " Cool looking status bar and tabs
   Plug 'vim-airline/vim-airline'
   Plug 'vim-airline/vim-airline-themes'

   " Highlight other workds
   Plug 'RRethy/vim-illuminate'

   " Javascript goodness
   Plug 'pangloss/vim-javascript'

   " Autocomplete
   " Plug 'Valloric/YouCompleteMe'
   Plug 'neoclide/coc.nvim', {'branch': 'release'}
   " Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
   " Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}

   " Easy commenting of blocks and lines
   Plug 'tomtom/tcomment_vim'

   " Supposed to make it easy to switch betweek panes
   " Plug 'dflupu/vim-iterm2-navigator'
   Plug 'christoomey/vim-tmux-navigator'

   " Bracket stuff
   Plug 'tpope/vim-endwise'
   Plug 'jiangmiao/auto-pairs'
   Plug 'tpope/vim-surround'

   " lint
   " Plug 'w0rp/ale'
   Plug 'dense-analysis/ale'

   " syntax highlighting for template literals
   Plug 'jonsmithers/vim-html-template-literals'

   " quick navigation based of first letter
   Plug 'easymotion/vim-easymotion'

   " incremental search
   Plug 'haya14busa/incsearch.vim'

   " incremental fuzzy search
   Plug 'haya14busa/incsearch-fuzzy.vim'

   " links incremental search with easy motion
   Plug 'haya14busa/incsearch-easymotion.vim'

   " Plug 'c9s/helper.vim'
   " Plug 'c9s/treemenu.vim'
   " Plug 'c9s/vikube.vim'

   Plug 'ryanoasis/vim-devicons'

   Plug 'vimwiki/vimwiki'
call plug#end()

" General Stuff
set nocompatible
filetype plugin on
set directory=$HOME/.vim/swap_files/
" makes it so the you can use the clipboard
" set clipboard=unnamed
set nospell spelllang=en_us
autocmd BufWritePre * %s/\s\+$//e
augroup myvimrchooks
  au!
  autocmd bufwritepost .vimrc source ~/.vimrc
augroup END
set bs=2
imap jj <Esc>

" Tabs Spacing
set expandtab
set tabstop=4
set softtabstop=2
set shiftwidth=2
" set ttymouse=xterm2
" set ttymouse=sgr
set mouse=a
set hidden

"Always display status bar
set laststatus=2
set ruler

" Line Number
set number relativenumber
set nu rnu

" Highlight Cursor Line
set cursorline

set hlsearch
set ignorecase

let g:rainbow_active = 1

"Set title to current file name
set title

"Show commands as I type them.
set showcmd

" Max Characher Line
set colorcolumn=80

" Easymotion
nmap <Space> <Plug>(easymotion-s)

" TComment
map <C-c> :TComment<CR>

" Fugitive
map <leader>gs :Gstatus<cr>
map <leader>gc :Gcommit<cr>

" NerdTree
let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>

" vim-javascript
let g:javascript_plugin_jsdoc = 1

let g:markdown_fenced_languages = ['html', 'javascript', 'bash=sh', 'sql']

" ctrlp
" let g:ctrlp_show_hidden = 1
" let g:ctrlp_custom_ignore = {
"   \ 'hidden-dir':  '\v[\/]\.(git)$',
"   \ 'dir':  '\v[\/](node_modules|coverage|allure)$'
"   \ }

nmap <leader><tab> <plug>(fzf-maps-n)
nmap <C-p> :Files! <cr>
nmap <leader>p :GFiles!<cr>
nmap <leader>r :Rg!<space>
let g:fzf_buffers_jump = 1

" Theme
syntax on
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_vert_split = 'yellow'
let g:gruvbox_bold = 1
let g:gruvbox_termcolors = 256
set background=dark
" set background=light
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
colorscheme gruvbox

" airline
" let g:airline_theme='badwolf'
let g:airline_theme='gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'jsformatter'
let g:airline_powerline_fonts = 1
let g:airline#extensions#bufferline#enabled = 0
let g:airline#extensions#tabline#show_buffers = 0

" ale
let g:ale_fixers = {'javascript': ['prettier', 'eslint']}
let g:ale_linters = {'javascript': ['eslint']}
let g:ale_fix_on_save = 1
map <leader>ff :ALEFix<cr>
nmap <silent> <leader>k <Plug>(ale_previous_wrap)
nmap <silent> <leader>j <Plug>(ale_next_wrap)
let b:ale_set_highlights = 1 " Disable highligting
highlight ALEWarning ctermfg=236 ctermbg=208 cterm=bold
highlight ALEError ctermfg=236 ctermbg=167 cterm=bold

" YouCompleteMe
" let g:ycm_goto_buffer_command = 'split-or-existing-window'
" nnoremap <leader>gt :leftabove vertical YcmCompleter GoTo<CR>

" coc - Remap keys for gotos
" let g:coc.preferences.jumpCommand = 'vsplit'
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

"" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" inoremap <silent><expr> <Tab>
"       \ pumvisible() ? "\<C-n>" :
"       \ <SID>check_back_space() ? "\<Tab>" :
"       \ coc#refresh()
" inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <Tab> pumvisible() ? "\<C-y>" : "\<Tab>"
nnoremap <silent> td :<C-u>CocList todolist<cr>

" IncSearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

map z/ <Plug>(incsearch-easymotion-/)
map z? <Plug>(incsearch-easymotion-?)
map zg/ <Plug>(incsearch-easymotion-stay)

let g:tmux_navigator_no_mappings = 1

nnoremap <silent> <C-h> :TmuxNavigateLeft<cr>
nnoremap <silent> <C-j> :TmuxNavigateDown<cr>
nnoremap <silent> <C-k> :TmuxNavigateUp<cr>
nnoremap <silent> <C-l> :TmuxNavigateRight<cr>
nnoremap <silent> <C-\> :TmuxNavigatePrevious<cr>

" incsearch.vim x fuzzy x vim-easymotion
function! s:config_easyfuzzymotion(...) abort
  return extend(copy({
  \   'converters': [incsearch#config#fuzzy#converter()],
  \   'modules': [incsearch#config#easymotion#module()],
  \   'keymap': {"\<CR>": '<Over>(easymotion)'},
  \   'is_expr': 0,
  \   'is_stay': 1
  \ }), get(a:, 1, {}))
endfunction
noremap <silent><expr> <Space>/ incsearch#go(<SID>config_easyfuzzymotion())

" let g:vikube_autoupdate = 1
let g:vikube_default_logs_tail = 100

" vimwiki
nmap  <Leader>wv <Plug>VimwikiVSplitLink
let g:vimwiki_list = [{'path': '~/Documents/vimwiki/',
                      \ 'syntax': 'markdown', 'ext': '.md'}]
