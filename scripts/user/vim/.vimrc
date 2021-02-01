set exrc

set nocompatible
filetype off

nnoremap <space> <nop>
let mapleader=" "

call plug#begin('~/.vim/plugged')

    " Completion
    Plug 'valloric/youcompleteme', {'do': './install.py --clangd-completer --rust-completer'}
    Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
    Plug 'vim-scripts/dbext.vim'
    Plug 'mattn/emmet-vim'

    " Snippets
    Plug 'SirVer/ultisnips'
    Plug 'honza/vim-snippets'

    " Markdown
    Plug 'tpope/vim-markdown'
    Plug 'junegunn/goyo.vim'

    " Git
    Plug 'tpope/vim-fugitive'

    " Rust
    Plug 'rust-lang/rust.vim'

    " Misc
    Plug 'scrooloose/nerdtree'
    Plug 'scrooloose/nerdcommenter'
    Plug 'vim-airline/vim-airline'
    Plug 'vim-syntastic/syntastic'
    "Plug 'beloglazov/vim-online-thesaurus'
    Plug 'tpope/vim-surround'
    Plug 'tpope/vim-repeat'
    Plug 'tpope/vim-eunuch'
    Plug 'michaeljsmith/vim-indent-object'
    Plug 'wfxr/minimap.vim'
    Plug 'luochen1990/rainbow'
    Plug 'Valloric/MatchTagAlways'
    Plug 'mhinz/vim-startify'

    " Finders
    if executable('fzf')
        Plug 'junegunn/fzf'
        Plug 'junegunn/fzf.vim'
    else
        Plug 'ctrlpvim/ctrlp.vim'
    endif

    " Writing
    Plug 'reedes/vim-pencil'

    " Themes
    Plug 'vim-airline/vim-airline-themes'
    Plug 'croaker/mustang-vim'

    " Nav
    Plug 'easymotion/vim-easymotion'
    Plug 'yuttie/comfortable-motion.vim'
    Plug 'unblevable/quick-scope'

    Plug 'majutsushi/tagbar'

    Plug 'francoiscabrol/ranger.vim'

    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
call plug#end()

filetype plugin indent on

set path+=** "matches everything under the base directory tree

set wildmenu "upgrades tab completion for buffer/file selection

set relativenumber
set numberwidth=3 " 3 is enough

"set signcolumn=yes " always show the error column, to prevent jarring jumps
set signcolumn=number " better yet, put them in the numbers column

set clipboard=unnamedplus

set backspace=indent,eol,start  " allow backspace in insert mode

set encoding=utf-8

set expandtab
set tabstop=4       " smaller tabs
set shiftwidth=4
set wrap            " enable word wrapping
set linebreak       " only wrap at breaks
set autoindent
set smartindent
set hidden          " allow hidden buffers
set number          " line numbers
set smarttab
set hlsearch
set incsearch
set title
set history=1000
set undolevels=1000
set pastetoggle=<F2>
filetype plugin indent on " language-dependent indenting

" copy more lines between files
set viminfo='100,<9999,s100

set term=xterm
set t_Co=256
colorscheme mustang
syntax on

" Airline
set laststatus=2    " status bar always enabled
let g:airline#extensions#wordcount#enabled = 1
let g:airline_powerline_fonts = 1

" nerdcommenter
let g:NERDSpaceDelims = 1

" enable rainbow parentheses
let g:rainbow_active = 1

" quickscope
let g:qs_highlight_on_keys = ['f', 'F', 't', 'T']

set ttyfast
set mouse=a

let g:fzf_command_prefix = 'Fzf'
let g:fzf_history_dir = '~/.local/share/fzf-history'
if executable('fzf')
    nnoremap <leader>j :call fzf#vim#tags("'".expand('<cword>'))<cr>
    map <c-h> :FzfHistory<cr>
    map <Leader>h :FzfHistory<cr>
    map <c-p> :FzfFiles<cr>
    map <Leader>p :FzfFiles<cr>
    map <Leader>b :FzfBuffers<cr>
    command! -bang -nargs=* FzfAg call fzf#vim#ag(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0) " prevent search in filenames
    map <Leader>a :FzfAg<cr>
    map <Leader>l :FzfBLines<cr>
    map <Leader>/ :FzfBLines<cr>
    map <Leader>r :FzfRg<cr>
    map <Leader>t :FzfTags<cr>
else
    let g:ctrlp_map = '<c-p>'
    let g:ctrlp_cmd = 'CtrlPMixed'
    let g:ctrlp_max_files=0
    let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

    if executable('ag')
        let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
    endif
endif

let g:EasyMotion_do_mapping=0 " disable default mappings
let g:EasyMotion_smartcase=1  " enable case-insensitive search
nmap s <Plug>(easymotion-overwin-f2)
nmap <Leader><space> <Plug>(easymotion-bd-w)

map <Leader>q :qa!<CR>
map <Leader>w <c-w><c-w>
map <Leader><Left> :wincmd h<CR>
map <Leader><Right> :wincmd l<CR>
map <Leader><Up> :wincmd k<CR>
map <Leader><Down> :wincmd j<CR>

map <bs> <c-o><cr>

map <F3> :NERDTreeToggle<CR>

let g:tagbar_autoclose=1
map <F8> :TagbarToggle<CR>

map <F4> :MinimapToggle<CR>

nmap <Leader>` :below terminal<CR>
set termwinsize=10x0

let g:pencil#wrapModeDefault = 'soft'

augroup pencil
  autocmd!
  autocmd FileType markdown,mkd,text call pencil#init()
augroup END

" let MatchTagAlways work with Rust files
let g:mta_filetypes = {
    \ 'html' : 1,
    \ 'xhtml' : 1,
    \ 'xml' : 1,
    \ 'jinja' : 1,
    \ 'rust' : 1,
    \}

nnoremap <delete> dd

"jump to latest position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

":autocmd VimEnter * :AirlineRefresh

let g:ycm_confirm_extra_conf = 0

let g:UltiSnipsExpandTrigger = "<c-right>"
let g:UltiSnipsJumpForwardTrigger = "<c-down>"
let g:UltiSnipsJumpBackwardTrigger = "<c-up>"

let g:ycm_complete_in_comments = 1

if executable('rust-analyzer')
    let g:ycm_language_server =
    \ [
    \   {
    \     'name': 'rust',
    \     'cmdline': ['rust-analyzer'],
    \     'filetypes': ['rust'],
    \     'project_root_files': ['Cargo.toml']
    \   }
    \ ]
endif

" sane preview popup settings
set previewpopup=height:10,width:60,highlight:PMenuSbar
set completeopt+=popup
set completepopup=height:15,width:60,border:off,highlight:PMenuSbar

let g:syntastic_rust_checkers = [] " remove cargo checker, takes up a lot of time even with no changes on writing
let g:cargo_shell_command_runner = 'below terminal'

nmap <silent> gd :botright vertical YcmCompleter GoToDefinition<cr>
nmap <silent> gi :YcmCompleter GoToImprecise<cr>
nmap <silent> gr :YcmCompleter GoToReferences<cr>
nmap <silent> gt :YcmCompleter GoTo<cr>

" retain visual selection after indenting:
vnoremap > >gv
vnoremap < <gv

" Russian
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

noremap <M-LeftMouse> <4-LeftMouse>
inoremap <M-LeftMouse> <4-LeftMouse>
onoremap <M-LeftMouse> <C-C><4-LeftMouse>
noremap <M-LeftDrag> <4-LeftDrag>
inoremap <M-LeftDrag> <4-LeftDrag>
onoremap <M-LeftDrag> <C-C><4-LeftDrag>

" make Home go to the first non-blank character
nnoremap <Home> ^

" 'fix' for https://github.com/vim/vim/issues/5617 (random [>4;2m appearing)
let &t_TI=""
let &t_TE=""

" undo across sessions
let vim_dir = '$HOME/.vim'
let &runtimepath.=','.vim_dir

if has('persistent_undo')
    let undo_dir = expand(vim_dir . '/undo')

    call system('mkdir ' . vim_dir)
    call system('mkdir ' . undo_dir)
    let &undodir = undo_dir
    set undofile
    set undolevels=1000
    set undoreload=10000    " max lines to save
endif

autocmd User StartifyReady call ToggleSidebars()
function! ToggleSidebars()
    NERDTreeToggle
    wincmd p
    MinimapToggle
endfunction

" quickly close cargo output terminal buffer
autocmd TerminalOpen * if &buftype ==# 'terminal'|nnoremap <buffer>q :q<CR>|endif
