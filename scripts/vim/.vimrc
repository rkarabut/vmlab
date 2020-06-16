set exrc

" required for Vundle

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()

    Plugin 'gmarik/Vundle.vim'

    Plugin 'tpope/vim-markdown'
    Plugin 'tpope/vim-fugitive'
    Plugin 'scrooloose/nerdtree'
    Plugin 'scrooloose/nerdcommenter'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-syntastic/syntastic'
    Plugin 'tpope/vim-surround'
    Plugin 'tpope/vim-repeat'
	Plugin 'tpope/vim-eunuch'
	Plugin 'michaeljsmith/vim-indent-object'

	" Finders
    if executable('fzf')
        Plugin 'junegunn/fzf'
        Plugin 'junegunn/fzf.vim'
    else
        Plugin 'ctrlpvim/ctrlp.vim'
    endif
    
    Plugin 'vim-airline/vim-airline-themes'
    Plugin 'croaker/mustang-vim'

	" Nav
	Plugin 'easymotion/vim-easymotion'
    Plugin 'yuttie/comfortable-motion.vim'

	Plugin 'majutsushi/tagbar'
call vundle#end()

filetype plugin indent on " language-dependent indenting

set path+=** "matches everything under the base directory tree

set wildmenu "upgrades tab completion for buffer/file selection

set relativenumber

set clipboard=unnamed
set paste

set backspace=indent,eol,start  " allow backspace in insert mode

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
set ttyfast
set mouse=a

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


let g:fzf_command_prefix = 'Fzf'
let g:fzf_history_dir = '~/.local/share/fzf-history'
if executable('fzf')
    nnoremap <leader>j :call fzf#vim#tags("'".expand('<cword>'))<cr>
    map <c-h> :FzfHistory<cr>
    map <c-p> :FzfFiles<cr>
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
nmap , <Plug>(easymotion-bd-w)
    
map <bs> :pop<cr>

map <F3> :NERDTreeToggle<CR>

let g:tagbar_autoclose=1
map <F8> :TagbarToggle<CR>

vmap <tab> >gv
vmap <s-tab> <gv

nnoremap <delete> dd

"jump to latest position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

":autocmd VimEnter * :AirlineRefresh

" retain visual selection after indenting:
vnoremap > >gv
vnoremap < <gv

" better Cyrillic support
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0

noremap <M-LeftMouse> <4-LeftMouse>
inoremap <M-LeftMouse> <4-LeftMouse>
onoremap <M-LeftMouse> <C-C><4-LeftMouse>
noremap <M-LeftDrag> <4-LeftDrag>
inoremap <M-LeftDrag> <4-LeftDrag>
onoremap <M-LeftDrag> <C-C><4-LeftDrag>
