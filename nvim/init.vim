syntax on
filetype plugin indent on

set hidden splitright updatetime=100 ai sw=2 et sts=2 sr nowrap noswapfile
set undofile undolevels=1024 undoreload=2048 conceallevel=0 concealcursor+=nvc
set modelines=1 exrc secure confirm number relativenumber scrolloff=5
set hlsearch incsearch showmatch ignorecase smartcase splitbelow splitright
set listchars=tab:→\ ,nbsp:␣,trail:• list termguicolors noshowmode
set shortmess+=ac signcolumn=yes nospell foldcolumn=2 nowritebackup nocompatible
set shell=/usr/local/bin/fish

let mapleader = "\<Space>"
let &showbreak = '> '
let &fileencodings .= 'gb2312,gb18030,gbk,cp936,shift_jis,euc_kr'

let g:paper_hide_statusline = 1
let g:paper_hide_vert_split = 1
let g:paper_hide_end_of_buffer = 1
let g:paper_enable_filetype_specific_highlighting_group = 1
let g:NERDSpaceDelims = 1
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeMinimalMenu = 1
let g:NERDTreeBookmarksFile = '/dev/null'
let g:NERDTreeQuitOnOpen = 1
let g:NERDTreeAutoDeleteBuffer = 1
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeIgnore = [
    \ '\.DS_Store',
    \ '\.git$',
    \ 'node_modules$',
    \ ]
let g:dispatch_no_maps = 1
let g:gitgutter_preview_win_floating = 0
let g:fzf_layout = { 'down': '~50%' }
let g:polyglot_disabled = ['autoindent']
let g:lightline = {
    \ 'colorscheme': 'paper',
    \ 'active': {
        \ 'left': [
            \ ['mode', 'paste'],
            \ ['branch', 'file'],
        \ ],
        \ 'right': [
            \ ['precentage'],
            \ [],
            \ ['filetype'],
        \ ],
    \ },
    \ 'inactive': {
        \ 'left': [['file']],
        \ 'right': [[]],
    \ },
    \ 'component_function': {
        \ 'mode': 'utils#mode',
        \ 'branch': 'utils#git_branch',
        \ 'file': 'utils#filename',
        \ 'filetype': 'utils#filetype',
        \ 'precentage': 'utils#file_percentage',
    \ },
    \ 'tabline': {
        \ 'right': [[]],
    \ },
\}

nnoremap <leader>f :Files<CR>
nnoremap <leader>s :Rg<CR>
nnoremap <leader>' :Marks<CR>
nnoremap <leader>gp :Dispatch! git push<CR>
nnoremap <silent><leader>m :NERDTreeToggle<CR>
nnoremap \ <CMD>nohlsearch<CR>
cnoremap w!! w !sudo tee % >/dev/null
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ utils#check_backspace() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr><CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-refeences)
nnoremap <silent>K :call utils#show_documentation()<CR>
nnoremap <silent><leader>ld :CocList diagnostics<CR>
vnoremap < <gv
vnoremap > >gv

command! -bang -nargs=* -complete=file W w<bang> <args>
command! -bang -nargs=* -complete=file Wq wq<bang> <args>
command! -bang -nargs=* -complete=file WQ wq<bang> <args>
command! -bang Wa wa<bang>
command! -bang WA wa<bang>
command! -bang Q q<bang>
command! -bang QA qa<bang>
command! -bang Qa qa<bang>

call plug#begin($XDG_CACHE_HOME ? $XDG_CACHE_HOME : $HOME . '/.cache/nvim')

    Plug 'equt/paper.vim'
    Plug 'itchyny/lightline.vim'
    Plug 'junegunn/fzf', { 'do': './install --bin' }
    Plug 'junegunn/fzf.vim'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-dispatch'
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'scrooloose/nerdtree'
    Plug 'scrooloose/nerdcommenter'
    Plug 'mattn/emmet-vim'
    Plug 'neoclide/coc.nvim', { 'branch': 'release' }
    Plug 'sheerun/vim-polyglot'
    Plug 'ryanoasis/vim-devicons'

call plug#end()

augroup VimPlugAutoInstall
    autocmd!
    autocmd VimEnter *
        \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
        \|     PlugInstall --sync | q
        \| endif
augroup END

augroup VimOpenAtLastPosition
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ |   exe "normal! g`\""
        \ | endif
augroup END

augroup NERDTreeOnOpenAction
    autocmd!
    autocmd StdinReadPre * let s:std_in=1
    autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in')
        \| exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif
    autocmd BufEnter * if (winnr('$') == 1 && exists('b:NERDTree') &&
        \ b:NERDTree.isTabTree()) | q | endif
augroup END

augroup FZFSetStatusLine
    autocmd!
    autocmd! User FzfStatusLine call utils#fzf_statusline()
augroup END

augroup CoCHighlightCursorWord
    autocmd!
    autocmd CursorHold * silent call CocActionAsync('highlight')
augroup END

if utils#dark()
    let &background = 'dark'
else
    let &background = 'light'
endif
colorscheme paper

call coc#config('suggest.noselect', v:false)
